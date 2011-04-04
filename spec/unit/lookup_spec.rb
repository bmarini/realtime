require 'spec_helper'

class LookupSpec < MiniTest::Spec
  describe "Realtime::Lookup" do
    before do
      Realtime.configure do |c|
        c.middleman    = Realtime::SimpleMiddleman.new
      end
    end

    it "collects updates based on an entry" do
      entry = {
        "uid"            => 1335845740,
        "changed_fields" => [ "name", "picture" ],
        "time"           => 232323
      }

      Koala::Facebook::GraphAPI.any_instance.expects(:get_connections).twice.
        returns([Realtime::Update.new(nil,nil)])

      Realtime::Hub.expects(:publish).twice

      Realtime::Lookup.perform(entry)
    end
  end
end