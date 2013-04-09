class App < Sinatra::Base
  get %r{^/search(/page([\d]+))?/?$}, :auth => :user do |a, b|
    if params.has_key? 'query'
      query = params['query']
      @messages = Message.search query, :page => b
    end
    haml :'search/search', :locals => { :no_nav => true }
  end
end