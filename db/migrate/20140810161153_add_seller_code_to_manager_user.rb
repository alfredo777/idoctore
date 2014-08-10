class AddSellerCodeToManagerUser < ActiveRecord::Migration
  def change
    add_column :manager_users, :seller_code, :string
  end
end
