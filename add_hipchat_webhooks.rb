#!ruby

require 'yaml'
require 'pp'

require 'rubygems'
require 'json'
require 'HTTParty'

puts 'adding hipchat hooks to repos'

# load webhooks.yml

config = 'webhooks.yml.secret'
file = File.open(config)
yaml = YAML::load(file)
tab = "\t"

# get hipchat info from webhooks.yml

hipchat = yaml['hipchat']
hipchat_auth_token = hipchat['auth_token']
hipchat_room = hipchat['room']
puts 'hipchat auth token: ' + hipchat_auth_token
puts 'hipchat room: ' + hipchat_room



# get github info from webhooks.yml
github = yaml['github']

github_api_url = github['api_url'] 
puts "github api url: " + github_api_url

github_username = github['username']
github_password = github['password']

github_auth_credentials = Base64.encode64(github_username + ":" + github_password)
puts "github auth credentials: " + github_auth_credentials

headers = {}
headers["Authorization"] = "Basic " + github_auth_credentials


# get collection of repos to update  
updates = []
  
github_accounts = github['accounts']
github_accounts.each do |account|
  account.each_pair do |name, repos|
    puts "github account name: " + name
    
    repos.each do |repo|
      puts tab + "github repo: " + repo
      updates << { :account => name, :repo => repo }
    end
  end
end


# update the webhooks for each repository

updates.each do |update|
  puts
  repo = update[:repo]
  account = update[:account]
  url = github_api_url + "/repos/" + account + "/" + repo + "/hooks"
  puts url
  
  headers.each_pair do |key, value|
    puts key + ": " + value
  end

  
  hipchat_config = {
    :auth_token => hipchat_auth_token,
    :room => hipchat_room,
    :notify => nil
  }
  
  hipchat_hook = {
      :name => "hipchat",
      :active => true,
      :config => hipchat_config
    }
  
  puts hipchat_hook.to_json

  puts "going to send"
  response = HTTParty.post(url, :headers => headers, :body => pivotal_hook.to_json)
  puts response
      
end