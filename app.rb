require 'blather/client/client'
require 'blather/stanza/presence/muc'
require 'sinatra/activerecord'
require 'sinatra/base'

class App < Sinatra::Base
  set :raise_errors, false
  set :show_exceptions, true if development?
  set :haml, { :ugly => true } if production?
  set :views, File.join(settings.root, 'app', 'views')

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
    end
  end
end

require './app/models/user'
require './app/models/message'
require './app/controllers/users'
require './app/controllers/messages'
require './app/controllers/errors'
require './app/helpers/users'
require './app/helpers/messages'
