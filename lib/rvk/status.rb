module Vkontakte
  module Status
    def set_status(text)
      request = open('http://vk.com/profile.php', 'Cookie' => "remixsid=#{self.session}")
      @profile = request.read.to_s
      set_microblog_status(text)
    end
    
    def set_microblog_status(text)
      url = URI.parse('http://vk.com/al_wall.php')
      request = Net::HTTP::Post.new(url.path)
      request.set_form_data({
        'al'            => 1,
        'act'           => 'post',
        'to_id'         => find_in_profile(/"user_id":"?(\d+)"?/),
        'hash'          => find_in_profile(/"post_hash":"([^"]+)"/),
        'message'       => text,
        'note_title'    => '',
        'status_export' => ''
      })
      request['cookie'] = "remixsid=#{self.session}"

      Net::HTTP.new(url.host, url.port).start { |http| http.request(request) }
    end
    
    def find_in_profile(regexp)
      if match = @profile.match(regexp)
        match[1]
      else
        raise VkontakteError, "Could not find #{regexp}"
      end
    end
  end
end
