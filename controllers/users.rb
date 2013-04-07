require 'digest'

class App < Sinatra::Base
  register do
    def auth(type)
      condition do
        redirect '/login' unless send("is_#{type}?")
      end
    end
  end

  before do
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  get '/login' do
    erb :'users/login', :locals => { :no_header => true }
  end

  post '/login' do
    user = User.authenticate(params[:login], params[:password])
    if user 
      session[:user_id] = user.id
      session[:csrf_token] = Digest::MD5.hexdigest(Random.rand.to_s)
      redirect to '/'
    else
      @flash = 'Invalid credentials'
      erb :'users/login', :locals => { :no_header => true }
    end
  end

  get '/logout/:csrf_token' do |csrf_token|
    if csrf_token == session[:csrf_token]
      session[:user_id] = nil
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end