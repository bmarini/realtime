module Realtime
  class Hub
    class << self
      def subscribe(subscriber)
        subscribers.push(subscriber)
      end

      def publish(user, update)
        Realtime.logger.info "WARNING: No subscribers for Realtime::Hub" if subscribers.empty?

        subscribers.each do |subscriber|
          subscriber.call(user, update)
        end
      end

      def subscribers
        @subscribers ||= []
      end
    end
  end
end