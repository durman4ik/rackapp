module Lobster
  class BaseController
    attr_reader :env, :params, :request

    def initialize(request)
      @request = request
      @env = @request.env
      @params = @request.params
    end

    def render(view)
      Rack::Response.new(
          render_template('/layouts/application') do
            render_template("/#{view}")
          end
      )
    end

    def redirect(path)
      response = Rack::Response.new(env)
      response.redirect("/#{path}")
      response
    end

    private

    def render_template(path, &block)
      Tilt.new(file(path)).render(self, &block)
    end

    def file(path)
      dir = Dir[File.join('app', 'views', "#{path}.html.*")].first
      return dir if dir

      raise "Views not found for #{path}"
    end
  end
end
