class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :hashed_password
      t.string :salt
      t.string :email
      t.date :register
      t.string :confirmed_token
      t.boolean :confirmed, :default => :false
      t.boolean :confirmed, :default => :false
      t.text :description
      t.string :role
      t.text :resume
      t.datetime :last_loggin
      t.boolean :admin, :default => :false
      t.date :birthday

      t.timestamps
    end
  end
end
