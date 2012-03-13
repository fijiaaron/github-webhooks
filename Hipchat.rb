#!/usr/bin/env ruby

class Hipchat
  attr_accessor :auth_token, :room

  def initialize(config = {})
    @auth_token = config['auth_token']
    @room = config['room']
  end
end
