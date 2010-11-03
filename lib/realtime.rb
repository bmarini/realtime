require 'logger'
require 'koala'

module Realtime
  autoload :App,        "realtime/app"
  autoload :Config,     "realtime/config"
  autoload :Hub,        "realtime/hub"
  autoload :Lookup,     "realtime/lookup"
  autoload :Middleman,  "realtime/middleman"
  autoload :Subscriber, "realtime/subscriber"
  autoload :Update,     "realtime/update"
  autoload :Version,    "realtime/version"

  def self.logger
    Config.logger
  end

  def self.configure
    yield Config if block_given?
  end
end
