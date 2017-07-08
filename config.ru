require 'rubygems'
require 'bundler'
require './config/patchers/rack_patcher'
require 'sequel'

Dir[File.join(File.dirname(__FILE__), 'lib', '**', '*.rb')].each {|file| require file }
Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each {|file| require file }

if defined?(Bundler)
  Bundler.require
end

use Rack::Reloader
use Rack::Static, root: 'public', urls: %w(/images /css /js)
use Rack::CommonLogger
use Rack::ContentLength

use Lobster::Router do
  get '/'                => 'home#index'
  get '/users'           => 'users#index'
  get '/users/index'     => 'users#index'
  get '/users/new'       => 'users#new'
  get '/users/edit'      => 'users#edit'
  post '/users/create'   => 'users#create'
  post '/users/update'   => 'users#update'
  post '/users/delete'   => 'users#destroy'
end


run Lobster::App.new
