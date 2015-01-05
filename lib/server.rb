require 'sinatra/base'
require 'data_mapper'
require_relative './model/post.rb' # this needs to be done after datamapper is initialised

class MyApp < Sinatra::Base
  
  set :views, Proc.new{File.join(root, "..", "views")} 

  get '/' do
    @posts = Post.all 
    erb :index
  end


  # start the server if ruby file executed directly
  run! if app_file == $0

env = ENV['RACK_ENV'] || 'development'

# we're telling datamapper to use a postgres database on localhost. The name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment
DataMapper.setup(:default, "postgres://localhost/chitter_2_#{env}")


# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!

end
