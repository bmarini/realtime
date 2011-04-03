require 'rubygems'
require 'bundler/setup'

require 'minitest/autorun'
require 'minitest/spec'
require 'rack/mock'
require 'mocha'
require 'stringio'

require 'realtime'

module Realtime
  class SimpleMiddleman
    def initialize
      @last_checked = Hash.new { |h,k| Hash.new }
    end

    def access_token(user)
      user
    end

    def last_checked(user, field)
      @last_checked[user][field] || 0
    end

    def update_last_checked(user, field, time)
      @last_checked[user][field] = time
    end
  end
end