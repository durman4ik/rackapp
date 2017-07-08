$LOAD_PATH << File.expand_path(File.dirname(__FILE__))


module Lobster
  class << self
    attr_accessor :connection
  end

  autoload :Router,         'lobster/router'
  autoload :Connector,      'lobster/connector'
  autoload :BaseController, 'lobster/base_controller'
  autoload :App,            'lobster/app'
end
