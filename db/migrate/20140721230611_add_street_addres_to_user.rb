class AddStreetAddresToUser < ActiveRecord::Migration
  def change
    add_column :users, :street_addres, :text
  end
end
