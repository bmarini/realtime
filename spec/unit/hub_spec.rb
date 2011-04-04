require 'spec_helper'

class HubSpec < MiniTest::Spec
  describe "Realtime::Hub" do
    before { Realtime::Hub.clear! }

    it "must have a list of subscribers" do
      Realtime::Hub.subscribers.must_equal []
    end

    it "must accept new subscriptions" do
      subscriber1 = mock('subscriber1')
      subscriber2 = mock('subscriber2')

      Realtime::Hub.subscribe subscriber1
      Realtime::Hub.subscribe subscriber2

      Realtime::Hub.subscribers.must_equal [subscriber1, subscriber2]
    end

    it "must publish to all subscribers" do
      subscriber1 = mock('subscriber1', :call => nil)
      subscriber2 = mock('subscriber2', :call => nil)

      Realtime::Hub.subscribe subscriber1
      Realtime::Hub.subscribe subscriber2

      # Must trigger #call on all subscribers
      Realtime::Hub.publish '123', 'update_object'
    end
  end
end