module Vkontakte
  module Status
    
    def set_status text
      url = URI.parse('http://vk.com/wall.php')
      request = Net::HTTP::Post.new(url.path)
      request.set_form_data({
        'act'      => 'a_post_wall',
        'message'  => text,
        'reply_to' => -1
      }.merge(fetch_hash))
      request['cookie'] = "remixsid=#{self.session}"

      Net::HTTP.new(url.host, url.port).start { |http| http.request(request) }
    end
    
    def fetch_hash
      request = open('http://vk.com/profile.php', 'Cookie' => "remixsid=#{self.session}")
      profile = request.read.to_s
      if match = profile.match(/postStatus\((\d+), '([^']+)'\)/)
        { 'to_id' => match[1], 'hash' => decode_hash(match[2]) }
      else
        raise VkontakteError, "Could not find status hash"
      end
    end
    
    def decode_hash hash
      a = hash[-5..-1] + hash[4..hash.length-9]
      a.length.times.inject('') do |all, i|
        j = a.length - i - 1
        all + a[j..j]
      end
    end
    
  end
end
