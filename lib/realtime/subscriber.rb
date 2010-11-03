# Class for handling facebook realtime update subscriptions
module Realtime
  class Subscriber

    def list
      realtime_updates.list_subscriptions
    end

    # http://developers.facebook.com/docs/api/realtime
    def subscribe(subscription_object=nil, subscription_fields=nil)
      realtime_updates.subscribe(
        subscription_object || default_object,
        subscription_fields || default_fields,
        callback_url,
        verify_token
      )
    end

    def realtime_updates
      @realtime_updates ||= Koala::Facebook::RealtimeUpdates.new(
        :app_id => Config.app_id, :secret => Config.secret
      )
    end

    def default_object
      "user"
    end

    def default_fields
      "feed, friends, activities, interests, music, books, movies, television, likes, checkins"
    end

    def callback_url
      Config.callback_url
    end

    def verify_token
      Config.verify_token
    end
  end
end