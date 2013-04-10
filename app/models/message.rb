require 'thinking_sphinx'
require 'digest'

class Message < ActiveRecord::Base
  include ThinkingSphinx::ActiveRecord::Base
  
  attr_accessible :from, :body, :message_type, :created_at, :updated_at, :anchor

  before_save do |m|
    m.anchor = Digest::MD5.hexdigest(rand.to_s)[0..7] unless m.anchor
  end
end