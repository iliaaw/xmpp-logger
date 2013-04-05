class App < Sinatra::Base
  helpers do
    def html_escape(text)
      Rack::Utils.escape_html(text)
    end

    def last_day_path
      Message.last.created_at.strftime("/%Y/%m/%d")
    end

    def lz(number)
      # lz means 'leading zero'
      "%02d" % number.to_i
    end
  end
end