module Realtime
  class Middleman
    # return the facebook access token for this user
    def self.access_token(user)
      raise NotImplementedError, "access_token is not implemented"
    end

    # return a timestamp of the last time updates have been checked for
    # this user on this field
    #
    # Ex: $redis.get("realtime:lastchecked:#{user}:#{field}").to_i
    def self.last_checked(user, field)
      raise NotImplementedError, "last_checked is not implemented"
    end

    # update the last checked timestamp for this user for this field
    #
    # It's up to you where to store this data. Could be as simple as using
    # some Redis keys, or could store this info in MySQL in a users table
    #
    # Ex: $redis.set("realtime:lastchecked:#{user}:#{field}", time)
    def self.update_last_checked(user, field, time)
      raise NotImplementedError, "update_last_checked is not implemented"
    end
  end
end