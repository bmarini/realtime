module Realtime
  module Update
    attr_reader :field, :data

    def initialize(field, data)
      @field, @data = field, data
    end

    def uid
      @data["id"]
    end

    def inspect
      "Realtime::Update - #{@field} (#{@data.inspect})"
    end
  end
end
