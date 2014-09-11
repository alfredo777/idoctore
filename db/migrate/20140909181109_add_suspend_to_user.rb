class AddSuspendToUser < ActiveRecord::Migration
  def change
    add_column :users, :suspend, :boolean, default: false
  end
end
