module Vkontakte
  module Status
    def set_status(text)
      request = open('http://vk.com/profile.php', 'Cookie' => "remixsid=#{self.session}")
      @profile = request.read.to_s
      if @profile =~ /<input type='hidden' id='activityhash'/
        set_old_status(text)
      else
        set_microblog_status(text)
      end
    end
    
    def set_old_status(text)
      url = URI.parse('http://vk.com/profile.php')
      request = Net::HTTP::Post.new(url.path)
      request.set_form_data({'setactivity' => text, 'activityhash' => self.fetch_activityhash})
      request['cookie'] = "remixsid=#{self.session}"

      Net::HTTP.new(url.host, url.port).start { |http| http.request(request) }
    end
    
    def fetch_activityhash
      if match = @profile.match(/<input type='hidden' id='activityhash' value='([^']+)'>/)
        match[1]
      else
        raise VkontakteError, "Could not find status hash"
      end
    end
    
    def set_microblog_status(text)
      url = URI.parse('http://vk.com/wall.php')
      request = Net::HTTP::Post.new(url.path)
      request.set_form_data({
        'act'      => 'a_post_wall',
        'message'  => text,
        'reply_to' => -1
      }.merge(fetch_microblog_data))
      request['cookie'] = "remixsid=#{self.session}"

      Net::HTTP.new(url.host, url.port).start { |http| http.request(request) }
    end
    
    def fetch_microblog_data
      if match = @profile.match(/postStatus\((\d+), '([^']+)'\)/)
        hash = match[2]
        decoded_hash = (hash[-5..-1] + hash[4..hash.length-9]).reverse
        { 'to_id' => match[1], 'hash' => decoded_hash }
      else
        raise VkontakteError, "Could not find status hash"
      end
    end
    
  end
end
