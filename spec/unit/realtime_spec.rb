require 'spec_helper'

class RealtimeSpec < MiniTest::Spec
  describe "Realtime" do
    it "must have a logger" do
      Realtime.logger.must_respond_to :info
    end

    it "must expose configuration" do
      Realtime.configure do |c|
        c.must_equal Realtime::Config
      end
    end
  end
end