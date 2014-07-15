class CreateManagerUsers < ActiveRecord::Migration
  def change
    create_table :manager_users do |t|
      t.string :email
      t.string :password
      t.string :salt

      t.timestamps
    end
  end
end
