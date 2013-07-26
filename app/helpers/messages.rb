class App < Sinatra::Base
  helpers do
    def escape_text_message(message)
      message = Rack::Utils.escape_html(message)
      message.gsub!(/(https?:&#x2F;&#x2F;\S+)/, '<a href="\1">\1</a>')
      message.gsub!(/\n/, '<br />')
      message
    end

    def last_day_path
      Message.last.created_at.utc.strftime("/%Y/%m/%d")
    end

    def add_leading_zero(number)
      "%02d" % number.to_i
    end

    def group_messages_by_sender(messages)
      groups = [] << []
      from = nil
      messages.each do |m|
        if from.nil? || m.from == from
          groups.last << m
        else
          groups << ([] << m)
        end
        from = m.from
      end
      groups
    end
  end
end
