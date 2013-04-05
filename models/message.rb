class Message < ActiveRecord::Base
  attr_accessible :from, :body, :message_type, :created_at, :updated_at
end