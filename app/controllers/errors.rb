class App < Sinatra::Base
  error 404 do
    haml :'errors/404', :locals => { :no_container => true, :no_header => true }
  end

  error 500 do
    haml :'errors/500', :locals => { :no_container => true, :no_header => true }
  end
end