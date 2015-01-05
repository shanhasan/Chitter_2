class MyApp < Sinatra::Base

post '/post' do
    Post.create(:message => params['message'])
    redirect to('/')
  end
  
end