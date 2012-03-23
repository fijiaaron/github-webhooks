class Hipchat
  @@Name = 'hipchat'
  attr_accessor :auth_token, :room, :notify
  attr_accessor :dont_send
  
  
  def initialize(config = {})
    @auth_token = config['auth_token']
    @room = config['room']
    @notify = nil
  end
  
  
  def Name
       @@Name
  end
  
  
  def payload(auth_token=nil, room=nil, notify=nil)
    if auth_token != nil
      @auth_token = auth_token
    end
    
    if room != nil
      @room = room
    end
    
    if notify != nil
      @notify = notify
    end
    
    {:auth_token => auth_token, :room => room, :notify =>notify}
  end
  
end
