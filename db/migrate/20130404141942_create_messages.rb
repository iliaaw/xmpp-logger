class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :from
      t.text :body
      t.string :message_type

      t.timestamps
    end
  end
end
