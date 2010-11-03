module Realtime
  class Config
    class << self
      # This should be a url that points to the Realtime::App rack app.
      # For example: http://yourapp.tld/realtime/endpoint
      attr_accessor :callback_url

      # Your facebook app id and secret
      attr_accessor :app_id, :secret

      # Some random value unique to your application, can't be over 40 chars
      attr_accessor :verify_token

      attr_accessor :logger
      def logger
        @logger ||= defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
      end

      # An object that should respond to three methods:
      # * access_token(user)
      #   - return the facebook access token for this user
      #
      # * last_checked(user, field)
      #   - return a timestamp of the last time updates have been checked for
      #     this user on this field
      #
      # * update_last_checked(user, field, time)
      #   - update the last checked timestamp for this user for this field
      #
      # It's up to you where to store this data. Could be as simple as using
      # some Redis keys, or could store this info in MySQL in a users table
      attr_accessor :middleman
      def middleman
        @middleman ||= Middleman
      end
    end
  end
end