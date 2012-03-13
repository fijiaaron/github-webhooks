#!ruby

# webhooks.rb

require 'yaml'
require 'pp'

require 'rubygems'
require 'httparty'
require 'rest_client'
require 'json'

require 'Bamboo'
require 'Hipchat'
require 'Github'

config = 'webhooks.yml'
file = File.open(config)
yaml = YAML::load(file)
tab = "\t"

bamboo = Bamboo.new(yaml['bamboo'])

hipchat = Hipchat.new(yaml['hipchat'])

github = Github.new(yaml['github'])
  
#puts "bamboo--" 
#puts tab + "base_url: " + bamboo.base_url
#puts tab + "login: " + bamboo.login
#puts tab + "password: " + bamboo.password
#bamboo.plans.each do |name, plan|
#  puts tab + "plan: " + name
#  puts tab + tab + "branch: " + plan.branch.to_s
#  puts tab + tab + "build_key: " + plan.build_key.to_s
#end

#puts "hipchat--" 
#puts tab + "auth_token: " + hipchat.auth_token
#puts tab + "password: " + hipchat.room

#puts "github--"
#puts tab + "api_url: " + github.api_url
#puts tab + "auth_credentials: " + github.auth_credentials
#puts tab + "user: " + github.user
#github.repos.each do | name |
#  puts tab + "repo: " + name
#end
#github.repos.each do | repo |
#  pp github.get_hooks(repo)  
#end

github.set_bamboo_hook("authorization-server", "reflector")


