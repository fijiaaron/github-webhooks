#!ruby

require 'yaml'
require 'Github'
require 'Pivotal'

config = 'webhooks.yml'
file = File.open(config)
yaml = YAML::load(file)

github = Github.new(yaml['github'])

pivotal = Pivotal.new(yaml['pivotal'])
#pivotal.dont_send = true
  
puts 'updating pivotal webhooks'
github.update_accounts(pivotal)

puts "\n================\n"
puts 'done'

