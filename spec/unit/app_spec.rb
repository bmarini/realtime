require 'spec_helper'

class AppSpec < MiniTest::Spec

  describe "Realtime::App" do
    before do
      @log = StringIO.new

      Realtime.configure do |c|
        c.logger       = Logger.new(@log)
        c.callback_url = "/realtime/endpoint"
        c.verify_token = "somerandomsecretuniquetoyourapp"
      end
    end

    it "should meet the challenge" do
      url = "realtime/endpoint?%s" % query(
        'hub.mode'         => 'subscribe',
        'hub.verify_token' => 'somerandomsecretuniquetoyourapp',
        'hub.challenge'    => 'somechallengefromfacebook'
      )

      response = Rack::MockRequest.new(app).get(url)

      response.status.must_equal 200
      response.body.must_equal 'somechallengefromfacebook'
    end

    def app
      @app ||= Rack::Builder.new do
        map '/realtime/endpoint' do
          use Rack::Lint
          run Realtime::App.new
        end
      end
    end

    def query(params)
      params.map { |(k,v)| "#{k}=#{v}" }.join("&")
    end
  end
end
