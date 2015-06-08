class CreateAdminInOrganizations < ActiveRecord::Migration
  def change
    create_table :admin_in_organizations do |t|
      t.integer :organization_id
      t.integer :password
      t.string :email
      t.string :user_name
      t.boolean :super_admin

      t.timestamps
    end
  end
end
