#!ruby

require 'yaml'
require 'Github'
require 'Hipchat'

config = 'webhooks.yml'
file = File.open(config)
yaml = YAML::load(file)

github = Github.new(yaml['github'])
  
hipchat = Hipchat.new(yaml['hipchat'])
#hipchat.dont_send = true

puts 'updating hipchat webhooks'
github.update_accounts(hipchat)

puts "\n================\n"
puts 'done'