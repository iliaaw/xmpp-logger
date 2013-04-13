class App < Sinatra::Base
  get %r{^/search(/page([\d]+))?/?$}, :auth => :user do |group, page|
    if params.has_key? 'query'
      query = Riddle::Query.escape(params['query'])
      @messages = Message.search(query, :page => page)
    end
    haml :'search/search', :locals => { :no_nav => true }
  end
end