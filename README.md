## About the Realtime module

All the code in the Realtime module is for interacting with Facebook's Realtime
Update API: http://developers.facebook.com/docs/api/realtime

## Overview

Here is an overview of the classes, described in order of how they are called.

### Realtime::Subscriber

Responsible for making the initial subscription for updates to facebook.

### Realtime::App

This is the endpoint, and handles subscription verification and receiving
updates from facebook. This could be rewritten as a rack app if we ever want
to port this code. It receives an array facebook `entry` and passes them off
individually to `Realtime::Lookup`.

### Realtime::Lookup

RealtimeController hands off notifications of changes from facebook to this
class.

    Realtime::Lookup.perform(entry)

Lookup takes the `uid`, `field`, and `time` from the entry, looks up the User
to get an access token, and queries the facebook graph API to get any updates
of type `field` since `time`.

`Realtime::Lookup` then publishes these updates with `Realtime::Hub`

### Realtime::Hub

Listeners register with `Realtime::Hub`, and must define a method `#call`
which takes a Realtime::Update class as an argument. The Hub publishes the
update to all listeners.

Example initializer:

    # This ensures that in development mode, Hub won't get reloaded and lose its
    # listeners
    require 'realtime/hub'

    Realtime::Hub.register_listener lambda { |user, update|
      Rails.logger.info "Recieved facebook real-time update for user #{user}: #{update.inspect}"
    }
