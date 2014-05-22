class AddAdvancedKeyToUser < ActiveRecord::Migration
  def change
    add_column :users, :advanced_key, :string
  end
end
