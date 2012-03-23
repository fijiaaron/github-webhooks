#!/usr/bin/env ruby

require 'yaml'

require 'Email'
require 'Github'

config = 'webhooks.yml'
file = File.open(config)
yaml = YAML::load(file)

email = Email.new(yaml['email'])
github = Github.new(yaml['github'])

puts 'updating email webhooks'
github.update_accounts(email)

  