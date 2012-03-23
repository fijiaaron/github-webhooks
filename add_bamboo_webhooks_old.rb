#!/usr/bin/env ruby

require 'yaml'
require 'pp'
require 'base64'

require 'rubygems'
require 'json'
require 'HTTParty'

puts 'simple update of webhooks'

config = 'webhooks.yml.secret'
file = File.open(config)
yaml = YAML::load(file)
tab = "\t"

github = yaml['github']
#pp github

github_api_url = github['api_url'] 
puts "github api url: " + github_api_url

github_username = github['username']
github_password = github['password']

github_auth_credentials = Base64.encode64(github_username + ":" + github_password)
puts "github auth credentials: " + github_auth_credentials

headers = {}
headers["Authorization"] = "Basic " + github_auth_credentials
  
tasks = []
  
github_accounts = github['accounts']
github_accounts.each do |account|
  account.each_pair do |name, repos|
    puts "github account name: " + name
    
    repos.each do |repo|
      puts tab + "github repo: " + repo
      tasks << { :account => name, :repo => repo }
    end
  end
end

class Github
  attr_accessor :api_url, :auth_credentials
end

class Bamboo
  attr_accessor :base_url, :build_key, :login, :password
  @@Hook = "bamboo"
  
  def self.Hook
    @@Hook
  end
end

require "Bamboo"
bamboo = Bamboo.new(yaml['bamboo'])

tasks.each do |task|
  puts
  repo = task[:repo]
  account = task[:account]
  url = github_api_url + "/repos/" + account + "/" + repo + "/hooks"
  puts url
  
  headers.each_pair do |key, value|
    puts key + ": " + value
  end
  
  bamboo_config = { 
    :base_url => bamboo.base_url, 
    :build_key => bamboo.plans[repo].build_key,
    :username => bamboo.username, 
    :password => bamboo.password 
  }
  
  webhook = {
    :name => Bamboo.Hook,
    :active => true,
    :config => bamboo_config
  }
  
  puts bamboo_hook.to_json

  puts "going to send"
  response = HTTParty.post(url, :headers => headers, :body => webhook.to_json)
    
  puts response
end
  