class App < Sinatra::Base
  get '/search', :auth => :user do
    if params.has_key? 'query'
      query = params['query']
      @messages = Message.search(query)
    end
    haml :'search/search'
  end
end