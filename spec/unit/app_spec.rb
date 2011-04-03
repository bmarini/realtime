require 'spec_helper'

class AppSpec < MiniTest::Spec

  describe "Realtime::App" do
    before do
      @log = StringIO.new

      Realtime.configure do |c|
        c.logger       = Logger.new(@log)
        c.callback_url = "/realtime/endpoint"
        c.verify_token = "somerandomsecretuniquetoyourapp"
        c.middleman    = Realtime::SimpleMiddleman.new
      end
    end

    it "must meet the challenge" do
      response = Rack::MockRequest.new(app).get('/realtime/endpoint',
        :params => {
          'hub.mode'         => 'subscribe',
          'hub.verify_token' => 'somerandomsecretuniquetoyourapp',
          'hub.challenge'    => 'somechallengefromfacebook'
        }
      )

      response.status.must_equal 200
      response.body.must_equal 'somechallengefromfacebook'
    end

    it "must validate the challenge request" do
      response = Rack::MockRequest.new(app).get('/realtime/endpoint',
        :params => {
          'hub.mode'         => 'subscribe',
          'hub.verify_token' => 'someinvalidtoken',
          'hub.challenge'    => 'somechallengefromfacebook'
        }
      )

      response.status.must_equal 400
      response.body.must_equal 'Invalid'
    end

    it "must receive a change notification" do
      Realtime::Lookup.expects(:perform).twice

      response = Rack::MockRequest.new(app).post('/realtime/endpoint',
        :input => change_notification_json
      )

      response.status.must_equal 200
    end

    def app
      @app ||= Rack::Builder.new do
        map '/realtime/endpoint' do
          use Rack::Lint
          run Realtime::App.new
        end
      end
    end

    def change_notification_json
      <<-EOJ
{
  "object": "user",
  "entry": [{
    "uid": 1335845740,
    "changed_fields": ["name", "picture"],
    "time": 232323
  },
  {
    "uid": 1234,
    "changed_fields": ["friends"],
    "time": 232325
  }]
}
      EOJ
    end
  end
end
