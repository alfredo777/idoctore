class AddIdentifyToManagerUsers < ActiveRecord::Migration
  def change
    add_column :manager_users, :identify, :integer
  end
end
