Ruby Vkontakte Poster
=====================

Использование
-------------

    require 'rvk'
    
    u = Vkontakte::User.new session
    u = Vkontakte::User.new email, password

    u.add_note title, body
    u.set_status status

Основан на http://github.com/ai/twitter2vk