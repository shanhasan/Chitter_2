require_relative '../helper/users_helper.rb'

include Users_Helper

class MyApp < Sinatra::Base

  get '/users/new' do
    @user = User.new
    erb :"users/new"
  end

  post '/users' do
    @user = User.create(email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :"users/new"
    end
  end

  get '/users/forgot_password' do
    erb :"users/forgot_password"
  end
  
  post '/users/forgot_password' do
    user = User.first(email: params[:email]) 
    user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
    user.password_token_timestamp = Time.now
    user.save
    send_simple_message(user.password_token)
    erb :"users/password_sent"
  end

  # def send_simple_message(token)
  #   RestClient.post "https://api:key-3ax6xnjp29jd6fds4gc373sgvjxteol0"\
  #   "@api.mailgun.net/v2/samples.mailgun.org/messages",
  #   :from => "Password Reset Manager <me@samples.mailgun.org>",
  #   :to => "An excited user <#{params[:email]}>",
  #   # :to => "Shan <shan119@hotmail.co.uk>",
  #   :subject => "Hello", 
  #   :text => "Below is the link to rest your password: http://localhost:9292/users/reset_password/#{token}"
  # end

  get '/users/reset_password/:token' do
    @token = params[:token]
    user = User.first(password_token: @token)
    if Time.now < (user.password_token_timestamp + 3600)
      erb :"users/new_password"
    else
      flash[:notice] = "Password token timed out!"
      redirect to 'users/forgot_password'
    end
  end

  post '/users/reset_password' do
    user = User.first(password_token: params[:password_token]) 
    if user.update(password: params[:password], password_confirmation: params[:password_confirmation], password_token: nil)
      session[:user_id] = user.id
      redirect to('/')
    else
      flash.now[:errors] = user.errors.full_messages
      erb :"users/new_password"
    end
  end

end