Ruby Vkontakte Poster
=====================

Install
---------

    gem install rvk

Example
-------

    require 'rvk'
    
    u = Vkontakte::User.new email, password # or Vkontakte::User.new session

    u.add_note title, body
    u.set_status status

Based on [twitter2vk](http://github.com/ai/twitter2vk)