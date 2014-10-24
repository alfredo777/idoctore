class AddCanAccesAdminToManagerUser < ActiveRecord::Migration
  def change
    add_column :manager_users, :can_acces_admin, :boolean, default: true
  end
end
