class MyApp < Sinatra::Base

  get '/' do
    erb :"index"
  end

  post '/sessions' do
    email, password = params[:email], params[:password]
    user = User.authenticate(email, password)
    if user
      session[:user_id] = user.id
      redirect to('/homepage')
    else
      flash[:errors] = ["The email or password is incorrect"]
      erb :"index"
    end
  end

  delete '/sessions' do
    flash[:notice] = "Good bye!"
    session[:user_id] = nil
    redirect to('/')
  end

end