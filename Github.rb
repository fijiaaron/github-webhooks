require 'yaml'
require 'base64'
require 'pp'

require 'rubygems'
require 'HTTParty'
require 'json'

class Github
  attr_accessor :api_url, :username, :password, :auth_credentials
  
  
  def initialize(config={})
    @api_url = config['api_url']
    @username = config['username']
    @password = config['password']
    @auth_credentials = config['auth_credentials'] 
    @accounts = config['accounts']
      
    get_auth_credentials(@username, @password)        
  end
  
  
  def get_auth_credentials(username, password)
    if @auth_credentials.nil?
      if not (@username.nil?)
        @auth_credentials = Base64.encode64(username + ":" + password)  
      end
    end
    
    return @auth_credentials
  end
  
  
  def set_webhook(webhook, account, repo)
    puts "\n================\n"
    
    url = @api_url + "/repos/" + account + "/" + repo + "/hooks"
    puts url
    
    headers = get_headers()
    headers.each_pair do |key, value|
      puts key + ": " + value
    end
    
    payload = {
      :name => webhook.Name,
      :active => true,
      :config => webhook.payload()
    }
  
    puts
    puts payload.to_json

    puts "\n----------------\n"
          
    if webhook.dont_send
      puts "request not sent"
      return 
    end

    response = HTTParty.post(url, :headers => headers, :body => payload.to_json)    
    puts response
  end
  
  
  def update_accounts(webhook)
    @accounts.each do |account|
      account.each_pair do |account_name, repos|
        #puts "github account name: " + account_name
       
        repos.each do |repo|
          #puts "github repo: " + repo
            set_webhook(webhook, account_name, repo)
        end
      end
    end
  end
  
  
  def get_headers()
    headers = {}
    if not @auth_credentials.nil?
      headers["Authorization"] = "Basic " +  @auth_credentials
    end
    
    return headers
  end
  
end

