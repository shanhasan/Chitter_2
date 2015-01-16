class MyApp < Sinatra::Base

  get '/homepage' do
    @posts = Post.all 
    erb :homepage
  end

  post '/post' do
    Post.create(:message => params['message'])
    redirect to('/homepage')
  end
  
end