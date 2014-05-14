class CreateMessageUserToUsers < ActiveRecord::Migration
  def change
    create_table :message_user_to_users do |t|
      t.integer :user_id
      t.integer :to_user_id
      t.string :converstion_id

      t.timestamps
    end
  end
end
