class Pivotal
  @@Name = 'pivotaltracker'
  attr_accessor :token, :branch, :endpoint
  attr_accessor :dont_send  
  
  
  def initialize(config = {})
    @token = config['api_token']
    @branch = nil
    @endpoint = nil
  end
  
  
  def Name
       @@Name
  end
  
  
  def payload(token=nil, branch=nil, endpoint=nil)
    if token != nil
      @token = token
    end  
    
    if branch != nil
      @branch = branch
    end
    
    if endpoint != nil
      @endpoint = endpoint
    end
    
    {:token => @token, :branch => @branch, :endpoint => @endpoint}
  end
  
end