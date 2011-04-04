require 'spec_helper'

class MiddlemanSpec < MiniTest::Spec
  describe "Realtime::Middleman" do
    it "must raise exceptions for unimplemented interface" do
      assert_raises NotImplementedError do
        Realtime::Middleman.access_token(nil)
      end

      assert_raises NotImplementedError do
        Realtime::Middleman.last_checked(nil, nil)
      end

      assert_raises NotImplementedError do
        Realtime::Middleman.update_last_checked(nil, nil, nil)
      end
    end
  end
end