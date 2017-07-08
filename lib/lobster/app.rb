module Lobster
  class App
    attr_accessor :request, :env

    def call(request)
      self.request = request
      self.env = request.env
      dispatch
    end

    def dispatch
      if env[Rack::REQUEST_METHOD].downcase.to_sym == env['method']
        ctrl = controller.new(request)
        ctrl.public_send(env['action'])
      else
        Rack::Response.new(
          raise "Undefined method #{ env[Rack::REQUEST_METHOD] } for #{ env['controller'] }##{ env['action'] }"
        )
      end
    end

    def controller
      Object.const_get(env['controller'].capitalize + 'Controller')
    end
  end
end
