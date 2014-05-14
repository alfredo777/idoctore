class CreateDeleteHistories < ActiveRecord::Migration
  def change
    create_table :delete_histories do |t|
      t.integer :user_id
      t.integer :owner_id
      t.text :delete_content
      t.string :causes
      t.text :justify

      t.timestamps
    end
  end
end
