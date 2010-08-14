require 'open-uri'
require 'net/http'

$KCODE = 'u'

dir = File.dirname(__FILE__)
require File.join(dir, 'rvk/status')
require File.join(dir, 'rvk/note')
require File.join(dir, 'rvk/user')

module Vkontakte
  class VkontakteError < Exception; end;
end
