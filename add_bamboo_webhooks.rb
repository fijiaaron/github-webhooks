#!ruby

require 'yaml'
require 'Github'
require 'Bamboo'

config = 'webhooks.yml'
file = File.open(config)
yaml = YAML::load(file)

github = Github.new(yaml['github'])

bamboo = Bamboo.new(yaml['bamboo'])
#bamboo.dont_send = true
  
puts 'updating bamboo webhooks'
github.update_accounts(bamboo)

puts "\n================\n"
puts 'done'
