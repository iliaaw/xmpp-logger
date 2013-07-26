class App < Sinatra::Base
  # GET /search?query=text
  # GET /search/page2?query=text
  get %r{^/search(/page([\d]+))?/?$}, :auth => :user do |group, page|
    if params.has_key? 'query'
      query = Riddle::Query.escape(params['query'])
      @messages = Message.search(query, :page => page)
    end
    haml :'search/search', :layout => :search_layout
  end
end