#!ruby

require 'yaml'
require 'Github'
require 'Email'

config = 'webhooks.yml'
file = File.open(config)
yaml = YAML::load(file)

github = Github.new(yaml['github'])

email = Email.new(yaml['email'])
#email.dont_send = true

puts 'updating email webhooks'
github.update_accounts(email)

puts "\n================\n"
puts 'done'

  