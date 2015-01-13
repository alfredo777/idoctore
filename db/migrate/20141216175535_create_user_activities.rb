class CreateUserActivities < ActiveRecord::Migration
  def change
    create_table :user_activities do |t|
      t.string :activity
      t.integer :user_id

      t.timestamps
    end
  end
end
