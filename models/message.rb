class Message < ActiveRecord::Base
  attr_accessible :from, :body, :message_type
end