require 'open-uri'
require 'net/http'

require 'vkontakte/status'
require 'vkontakte/note'
require 'vkontakte/user'

module Vkontakte
  class VkontakteError < Exception; end;
end