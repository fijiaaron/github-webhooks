#!/usr/bin/env ruby

class Github 
  include HTTParty
  
  attr_accessor :api_url, :auth_credentials, :user
  attr_accessor :base_uri, :basic_auth
  attr_accessor :repos
  
  def initialize(config = {})
    @api_url = config['api_url']
  @base_uri = @api_url

    @auth_credentials = config['auth_credentials']
  @basic_auth = @auth_credentials 

    @user = config['user']
    @repos = Array.new
    config['repos'].each do |repo|
  puts repo
      @repos << repo
    end
  end

  def get_hooks(repo, user=nil)
    if (user == nil)
      user = @user 
    end
       
    request = get_hooks_url(repo, user)
    #puts "in get_hooks(): request: " + request
    
    headers = {}
    headers["Authorization"] = "Basic " + auth_credentials;
        
    response = HTTParty.get(request, :headers => headers) 
    #response = HTTParty.get(request, :headers => headers);
    
    return response
  end
  
  def get_hooks_url(repo, user=nil)
    if (user == nil)
      user = @user
    end
    
    request = "/repos/" + @user + "/" + repo + "/hooks"
    return base_uri + request
  end


  def set_bamboo_hook(repo, user, build_key, branch, base_url)
    request = "/repos" + user + "/" + repo + "/hooks"
    
    headers = {}
    headers["Authorization"] = "Basic " + auth_credentials
    
    bamboo = Bamboo.new
    
    config = { 'base_url' => base_url, 'build_key' => build_key, 'branch' => branch }
    
    payload = { name => "bamboo", active => true, config => config  }
       
    response = HTTParty.post(request, :headers => headers)
  end
    
  def get_hook_url(repo, hook_id)
  request = "/repos" + @user + "/" + repo + "/hooks" + "/" + hook_id
  return base_uri + request
  end
end

