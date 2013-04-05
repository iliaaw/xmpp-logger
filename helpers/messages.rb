class App < Sinatra::Base
  helpers do
    def escape_text_message(message)
      link_regex = /(http|https|ftp|ftps)\:&#x2F;&#x2F;[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(&#x2F;\S*)?/
      message = Rack::Utils.escape_html(message)
      message.gsub!(/(http:&#x2F;&#x2F;\S+)/, '<a href="\1">\1</a>')
      message.gsub!(/\n/, '<br />')
      message
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