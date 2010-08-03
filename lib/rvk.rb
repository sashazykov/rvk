require 'open-uri'
require 'net/http'

$KCODE = 'u'

require 'rvk/status'
require 'rvk/note'
require 'rvk/user'

module Vkontakte
  class VkontakteError < Exception; end;
end