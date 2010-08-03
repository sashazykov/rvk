module Vkontakte
  module Status
    
    def set_status text
      url = URI.parse('http://vk.com/profile.php')
      request = Net::HTTP::Post.new(url.path)
      request.set_form_data({'setactivity' => text, 'activityhash' => self.fetch_activityhash})
      request['cookie'] = "remixsid=#{self.session}"

      Net::HTTP.new(url.host, url.port).start { |http| http.request(request) }
    end
    
    def fetch_activityhash
      request = open('http://vk.com/profile.php', 'Cookie' => "remixsid=#{self.session}")
      profile = request.read.to_s
      if match = profile.match(/<input type='hidden' id='activityhash' value='([^']+)'>/)
        match[1]
      else
        raise VkontakteError, "Could not find status hash"
      end
    end
    
  end
end