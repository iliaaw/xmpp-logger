require 'yaml'
require 'active_record'
require 'blather/client/client'
require 'blather/stanza/presence/muc'
require 'eventmachine'
require 'thinking_sphinx'
require './app/models/message'

env = ENV['RACK_ENV'] || 'development'

db_config = YAML::load_file(File.join(File.dirname(__FILE__), 'config', 'database.yml'))[env]
ActiveRecord::Base.establish_connection(db_config)

xmpp_config = YAML::load_file(File.join(File.dirname(__FILE__), 'config', 'xmpp.yml'))[env]
xmpp_jid = xmpp_config['jid']
xmpp_password = xmpp_config['password']
xmpp_room = xmpp_config['room']
xmpp_nickname = xmpp_config['nickname']

EventMachine.run do
  xmpp_client = Blather::Client.setup(xmpp_jid, xmpp_password)
  xmpp_client.connect

  xmpp_client.register_handler :ready do
    join = Blather::Stanza::Presence::MUC.new
    join.to = "#{xmpp_room}/#{xmpp_nickname}"
    xmpp_client.write join
  end

  xmpp_client.register_handler :message, :groupchat? do |m|
    Message.create(
      :from => m.from.resource,
      :body => m.xhtml.blank? ? m.body : m.xhtml,
      :message_type => m.xhtml.blank? ? 'text' : 'xhtml'
    ) if m.body && !m.body.empty? && !m.delayed? && m.from.resource
  end
end
