class App < Sinatra::Base
  helpers do
    def html_escape(text)
      Rack::Utils.escape_html(text)
    end
  end
end