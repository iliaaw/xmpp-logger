ThinkingSphinx::Index.define :message, :with => :active_record do
  indexes :body

  has :from, :created_at
end