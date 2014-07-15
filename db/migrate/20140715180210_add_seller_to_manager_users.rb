class AddSellerToManagerUsers < ActiveRecord::Migration
  def change
    add_column :manager_users, :seller, :boolean
  end
end
