require 'rack'

# You'll want to map this rack app to the callback url configured in
# Realtime::Config.callback_url

module Realtime
  class App
    def call(env)
      @request  = Rack::Request.new(env)
      @response = Rack::Response.new

      @request.get? ? handle_challenge : handle_update

      @response.finish
    end

    protected

    def handle_challenge
      if challenge = meet_challenge
        @response.write challenge
      else
        @response.write "Invalid"
        @response.status = 400
      end
    end

    def handle_update
      # TODO: Verify the x-hub-signature, something like this:
      # Digest::SHA1.hexdigest( [digestable, secret].join )

      Realtime.logger.info "New update from facebook:"
      Realtime.logger.info "X-Hub-Signature: %s" % @request.env['HTTP_X_HUB_SIGNATURE']
      Realtime.logger.info @request.params.inspect

      # Lookup the data given the uid, time, and what changed
      params[:entry].each do |entry|
        Realtime::Lookup.perform(entry)
      end
    end

    def meet_challenge
      Realtime.logger.info "Received challenge from facebook:"
      Realtime.logger.info @request.params.inspect

      Koala::Facebook::RealtimeUpdates.meet_challenge(
        @request.params, Config.verify_token
      )
    end
  end
end