class Message < ActiveRecord::Base
  attr_accessible :from, :body, :message_type, :created_at, :updated_at

  def is_status?
    self.message_type == 'status'
  end
end