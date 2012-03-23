class Email
  @@Name = 'email'
  attr_accessor :address, :secret, :send_from_author
  attr_accessor :dont_send
  
  
  def initialize(config = {})
    @address = config['address']
    @secret = nil
    @send_from_author = 1
  end
  
  
  def Name
      @@Name
  end
  
  
  def payload(address=nil, secret=nil, send_from_author=nil)
    if address != nil 
      @address = address
    end
      
    if secret != nil
      @secret = secret
    end
    
    if send_from_author != nil
      @send_from_author = send_from_author
    end
      
    {:address => @address, :secret => @secret, :send_from_author => @send_from_author}
  end
  
end