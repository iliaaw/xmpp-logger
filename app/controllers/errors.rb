class App < Sinatra::Base
  error 404 do
    haml :'errors/404'
  end

  error 500 do
    haml :'errors/500'
  end
end