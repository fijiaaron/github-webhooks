class Email
  attr_accessor :address, :secret, :send_from_author
  @@Name = 'email'
  
  def initialize(config = {})
    @address = config['address']
    @secret = nil
    @send_from_author = 1
  end
  
  def Name
      @@Name
  end
  
  def payload(address=nil, secret=nil, send_from_author=true)
    if address != nil 
      @address = address
    end
      
    @secret = secret
    @send_from_author = send_from_author
      
    {:address=>@address, :secret=>@secret, :send_from_author=>@send_from_author}
  end
end