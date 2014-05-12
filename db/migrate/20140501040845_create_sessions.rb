class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id
      t.datetime :caduce

      t.timestamps
    end
  end
end
