require 'sinatra/base'
require 'data_mapper'

require_relative './model/post.rb' # this needs to be done after datamapper is initialised
require_relative './model/user.rb' # this needs to be done after datamapper is initialised

require_relative './helper/users_helper'
require_relative 'data_mapper_setup'

class MyApp < Sinatra::Base
  
  enable :sessions
  set :session_secret, 'super secret'
  set :views, Proc.new{File.join(root, "..", "views")} 

  get '/' do
    @posts = Post.all 
    erb :index
  end

  post '/post' do
    Post.create(:message => params['message'])
    redirect to('/')
  end

  get '/users/new' do
    erb :"users/new"
  end

  post '/users' do
    user = User.create(email: params[:email],
                       password: params[:password])
    session[:user_id] = user.id
    redirect to('/')
  end

  helpers Users_Helper

  # start the server if ruby file executed directly
  run! if app_file == $0

end