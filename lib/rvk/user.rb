module Vkontakte
  class User
    attr_accessor :session
    
    include Status
    include Note
    
    def initialize(*args)
      if (args.size == 1)
        self.session = args.first
      else
        self.session = self.fetch_session args
      end      
    end
    
    def fetch_session args
      (email, password) = args
      resource = Net::HTTP.post_form(URI.parse('http://login.vk.com/'), 
          { 'email' => email, 'pass' => password, 'vk' => '', 'act' => 'login' })
      if resource.body.empty?
        raise VkontakteError, "Could not fetch session"
      end
      resource.body.match(/id='s' value='([a-z0-9]+)'/)[1]
    end
  end
end