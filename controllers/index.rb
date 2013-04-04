class App < Sinatra::Base
  get '/' do
    @messages = Message.all
    erb :index
  end
end