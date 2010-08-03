module Vkontakte
  class User
    attr_accessor :session
    
    include Status
    include Note
    
    def initialize(*args)
      if (args.size == 1)
        self.session = args.first
      else
        self.session = self.fetch_session *args
      end      
    end
    
    def fetch_session email, password
      resource = Net::HTTP.post_form(URI.parse('http://login.vk.com/'), 
          { 'email' => email, 'pass' => password, 'vk' => '', 'act' => 'login' })
      if resource.body.empty?
        raise VkontakteError, "Could not fetch session"
      end
      if match = resource.body.match(/name='s' value='([a-z0-9]+)'/)
        match[1]
      else
        raise VkontakteError, "Could not find session"
      end
    end
  end
end
