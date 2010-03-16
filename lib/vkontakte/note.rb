module Vkontakte
  module Note
    
    def add_note title, text
      url = URI.parse('http://vk.com/notes.php')
      request = Net::HTTP::Post.new(url.path)
      request.set_form_data({ 'act' => 'add', 'preview' => '0', 'hash' => self.fetch_notehash,
                              'title' => title, 'post' => text })
      request['cookie'] = "remixsid=#{self.session}"

      Net::HTTP.new(url.host, url.port).start { |http| http.request(request) }
    end
    
    def fetch_notehash
      request = open('http://vk.com/notes.php?act=new', 'Cookie' => "remixsid=#{self.session}")
      profile = request.read.to_s
      profile.match(/<input type="hidden" name="hash" id="hash" value="([^"]+)">/)[1]
    end
    
  end
end