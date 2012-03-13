#!/usr/bin/env ruby

class Bamboo
  attr_accessor :base_url, :username, :password
  attr_accessor :plans

  def initialize(config = {})
    @base_url =  config['base_url']
    @username = config['username']
    @password = config['password']
    
    @plans = Hash.new

    config['plans'].each_pair do |key, value|
      plan = Bamboo_Plan.new(value)
      @plans[key] = plan 
    end
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
