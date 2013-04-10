class AddAnchorToMessage < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.string :anchor
    end

    Message.all.each do |m|
      m.save
    end
  end
end
