module Realtime
  class Lookup
    # Intentionally named for easy integration with Resque
    def self.perform(entry)
      user = entry['uid']

      updates = entry['changed_fields'].collect do |field|
        collect_updates( user, field, entry['time'] - 1 )
      end.flatten

      Realtime.logger.info "Updates found for user #{user}: #{updates.inspect}"

      updates.each do |update|
        Hub.publish(user, update)
      end
    end

    def self.collect_updates(user, field, time)
      unless_already_checked(user, field, time) do
        graph   = Koala::Facebook::GraphAPI.new( access_token_for(user) )
        updates = graph.get_connections('me', field, :since => time)

        updates.collect { |data| Update.new(field, data) }
      end
    end

    protected

    # Time must be a unix timestamp
    def self.unless_already_checked(user, field, time)
      return [] if last_checked(user, field) >= time
      update_last_checked(user, field, time)
      yield
    end

    def self.access_token_for(user)
      Config.middleman.access_token(user)
    end

    def self.last_checked(user, field)
      Config.middleman.last_checked(user, field)
    end

    def self.update_last_checked(user, field, time)
      Config.middleman.update_last_checked(user, field, time)
    end
  end
end
