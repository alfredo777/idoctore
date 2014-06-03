class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.integer :user_id
      t.integer :receiver_id
      t.string :typex
      t.integer :typex_id

      t.timestamps
    end
  end
end
