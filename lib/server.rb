require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'

require_relative './model/post.rb' # this needs to be done after datamapper is initialised
require_relative './model/user.rb' # this needs to be done after datamapper is initialised

require_relative './helper/users_helper'
require_relative 'data_mapper_setup'

require_relative './controllers/application.rb'
require_relative './controllers/posts.rb'
require_relative './controllers/users.rb'
require_relative './controllers/sessions.rb'

class MyApp < Sinatra::Base
  
  enable :sessions
  set :session_secret, 'super secret'
  use Rack::Flash
  set :methodoverride, true
  set :partial_template_engine, :erb


  set :views, Proc.new{File.join(root, "..", "..", "views")} 

  helpers Users_Helper

  # start the server if ruby file executed directly
  run! if app_file == $0

end