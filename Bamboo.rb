require 'pp'

class Bamboo
  @@Name = 'bamboo'
  attr_accessor :base_url, :username, :password
  attr_accessor :plans
  attr_accessor :dont_send
  
  
  def initialize(config = {})
    @base_url = config['base_url']
    @username = config['username']
    @password = config['password']
      
    @plans = createPlans(config['plans'])
  end
  
  
  def createPlans(config = {})
    plans = {}
      
    config.each_pair do |key, value|
      plan = Bamboo_Plan.new(value)
      plans[key] = plan 
    end
    
    return plans
  end
  
  
  def Name
       @@Name
  end
  
  
  def payload(config, base_url=nil, username=nil, password=nil, build_key=nil, branch=nil)
    if config.has_key?(:repo)
      repo = config[:repo]
      plan = plans[repo]
    else
      raise "need repo to determine plan"
    end
    
    if base_url == nil
      base_url = @base_url
    end
    
    if username == nil
      username = @username
    end
    
    if password == nil
      password = @password
    end
    
    if build_key == nil
      build_key = plan.build_key
    end
    
    if branch == nil
      branch = plan.branch
    end
    
    {:base_url => base_url, :username => username, :password => password, :build_key => build_key, :branch => branch}
  end
  
end


class Bamboo_Plan
  attr_accessor :build_key, :branch
  
  
  def initialize(config = {})
    if config.has_key?('build_key')
      @build_key = config['build_key']
    end
    
    if config.has_key?('branch')
      @branch = config['branch']
    end          
  end
  
end