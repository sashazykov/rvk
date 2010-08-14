Ruby Vkontakte Poster
=====================

A simple Ruby gem which help send notes and change status in VK.

Based on [twitter2vk](http://github.com/ai/twitter2vk) gem.

Install
---------

    gem install rvk

Example
-------

    require 'rvk'
    
    u = Vkontakte::User.new email, password # or Vkontakte::User.new session

    u.add_note title, body
    u.set_status status
    
Authors
-------

*   [Alexander Zykov](mailto:alexandrz@gmail.com)
*   [Andrey Sitnik](mailto:andrey@sitnik.ru)