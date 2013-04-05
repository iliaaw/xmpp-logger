require 'blather/client/client'
require 'blather/stanza/presence/muc'
require 'sinatra/activerecord'
require 'sinatra/base'

class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    Thread.start do
      @@xmpp_jid = 'JID'
      @@xmpp_password = 'PASSWORD' 
      @@xmpp_room = 'ROOM'
      @@xmpp_nickname = 'NICKNAME'

      @@xmpp_client = Blather::Client.setup(@@xmpp_jid, @@xmpp_password)
      @@xmpp_client.connect

      @@xmpp_client.register_handler :ready do
        join = Blather::Stanza::Presence::MUC.new
        join.to = "#{@@xmpp_room}/#{@@xmpp_nickname}"
        @@xmpp_client.write join
      end

      @@xmpp_client.register_handler :message, :groupchat? do |m|
        if m.body && !m.body.empty? && !m.delayed? && m.from.resource
          message = Message.new(
            :from => m.from.resource, 
            :body => m.xhtml.blank? ? m.body : m.xhtml,
            :message_type => m.xhtml.blank? ? 'text' : 'xhtml'
          )
          message.save
        end
      end

      @@xmpp_client.register_handler :status do |s|
        if "#{s.from.node}@#{s.from.domain}" == @@xmpp_room
          message = Message.new(
            :from => s.from.resource,
            :body => s.state,
            :message_type => 'status'
          )
          message.save
        end
      end
    end
  end
end

require './models/user'
require './models/message'
require './controllers/users'
require './controllers/messages'
require './helpers/users'
require './helpers/messages'