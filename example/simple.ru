# Usage: rackup simple.ru
#
# This file demonstrates the bare minimum needed to start consuming realtime
# updates from facebook

require 'bundler/setup'
require 'realtime'
require 'logger'

class SimpleMiddleman
  def initialize
    @last_checked = Hash.new { |h,k| Hash.new }
  end

  def access_token(user)
    # User.find_by_facebook_user_id(user).access_token
  end

  def last_checked(user, field)
    @last_checked[user][field] || 0
  end

  def update_last_checked(user, field, time)
    @last_checked[user][field] = time
  end
end

logger = Logger.new($stdout)

# Configuration
Realtime.configure do |c|
  c.callback_url = "/realtime/endpoint"
  c.app_id       = "facebookappid"
  c.secret       = "facebooksecret"
  c.verify_token = "somerandomsecretuniquetoyourapp"
  c.middleman    = SimpleMiddleman.new
end

# Subscribe to updates from facebook, by default subscribes to the "user"
# object, all fields: "feed, friends, activities, interests, music, books,
# movies, television, likes, checkins"
Realtime::Subscriber.subscribe

# Subscription to realtime.
Realtime::Hub.subscribe lambda { |user, update|
  logger.info "Recieved facebook real-time update for user #{user}: #{update.inspect}"
}

map '/realtime/endpoint' do
  use Rack::Lint
  run Realtime::App.new
end
