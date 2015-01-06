module Users_Helper

  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end

  def send_simple_message(token)
    RestClient.post "https://api:key-3ax6xnjp29jd6fds4gc373sgvjxteol0"\
    "@api.mailgun.net/v2/samples.mailgun.org/messages",
    :from => "Password Reset Manager <me@samples.mailgun.org>",
    :to => "An excited user <#{params[:email]}>",
    # :to => "Shan <shan119@hotmail.co.uk>",
    :subject => "Hello", 
    :text => "Below is the link to rest your password: http://localhost:9292/users/reset_password/#{token}"
  end

end