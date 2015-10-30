class RemovePhoneRegisterUser < ActiveRecord::Migration
  def change
    remove_column :user_registers, :phone
    add_column :user_registers, :phone, :string
  end
end
