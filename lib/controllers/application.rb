class MyApp < Sinatra::Base

  get '/' do
      @posts = Post.all 
      erb :index
    end

end