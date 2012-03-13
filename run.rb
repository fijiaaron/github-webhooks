require "yaml"
require "Bamboo"
require "Hipchat"
require "Github"

config = 'webhooks.yml'
file = File.open(config)
yaml = YAML::load(file)
tab = "\t"

bamboo = Bamboo.new(yaml['bamboo'])
puts "bamboo--" 
puts tab + "base_url: " + bamboo.base_url
puts tab + "login: " + bamboo.login
puts tab + "password: " + bamboo.password
bamboo.plans.each do |name, plan|
  puts tab + "plan: " + name
  puts tab + tab + "branch: " + plan.branch.to_s
  puts tab + tab + "build_key: " + plan.build_key.to_s
end

hipchat = Hipchat.new(yaml['hipchat'])
puts "hipchat--" 
puts tab + "auth_token: " + hipchat.auth_token
puts tab + "password: " + hipchat.room

puts "github--"
github = Github.new(yaml['github'])