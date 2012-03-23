require 'base64'
require 'pp' 
require 'rubygems'
require 'httparty'

class Github
  include HTTParty
  base_uri ='https://api.github.com'
  default_params :username => 'fijiaaron', :password => 'secret123'
  
  attr_accessor :username, :password 
  attr_accessor :accounts
  
  def initialize(config = {})
    puts 'Github#initialize()'
    if not config.empty?
      configure(config)
    end
  end
  
  def configure(config)
    puts 'Github#configure()'
    pp config
    @api_url = config['api_url']
    @username = config['username']
    @password = config['password']
   
    if config['repos'].is_a?(Array)
      puts 'repos is an Array'
      config['repos'].each do |repo|
        repo = GithubRepo.new(repo)
        
      end
    end
  end
  
  def create_auth_credentials(username, password)
    puts 'Github#create_auth_credentials()'
    return Base64.encode64(username + ":" + password)
  end
  
end

class GithubRepo
  attr_accessor :account, :name
  
  def initialize(config={})
    puts 'GithubRepo#initialize()'
  end
  
  def configure(config)
    puts 'GithubRepo#configure()'
  end  

  def get_webhooks(account, repo)
    puts 'GithubRepo#get_hooks'
    get('/repos/' + account + '/' + repo + '/hooks')
  end
  
end

yaml = 'new/webhooks.yml'
config = YAML::load(File.open(yaml))

g = Github.new(config['github'])