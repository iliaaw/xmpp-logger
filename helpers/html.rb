class App < Sinatra::Base
  helpers do
    def html_escape(text)
      Rack::Utils.escape_html(text)
    end

    def last_day_href
      Message.last.created_at.strftime("/%Y/%m/%d")
    end
  end
end