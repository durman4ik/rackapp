module Lobster
  class Router
    attr_reader :routes

    def initialize(app, &block)
      @app = app
      @routes = {}
      instance_eval(&block) if block_given?
    end

    def call(env)
      if(mapping = routes[env['PATH_INFO']])
        env.merge!(controller_action(mapping))
        @app.call(Rack::Request.new(env))
      else
        Rack::Response.new('Not Found', 404)
      end
    rescue Exception => error
      Rack::Response.new("Internal Server Error \n" + error.message, 500)
    end

    def get(*args)
      map_method(:get, *args)
    end

    def post(*args)
      map_method(:post, *args)
    end

    def put(*args)
      map_method(:put, *args)
    end

    def delete(*args)
      map_method(:delete, *args)
    end

    private

    def controller_action(mapping)
      Hash[ 'controller' => mapping['controller'], 'action' => mapping['action'], 'method' => mapping['method'] ]
    end

    def map_method(method, *args)
      options = {}
      path = args.first.keys.first
      controller, action = args.first.values.first.split('#')
      options['method'] = method
      options['controller'] = controller
      options['action'] = action
      match(path => options)
      self
    end

    def match(hash)
      self.routes.merge!(hash)
    end
  end
end
