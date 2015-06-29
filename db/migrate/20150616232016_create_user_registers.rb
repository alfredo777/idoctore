class CreateUserRegisters < ActiveRecord::Migration
  def change
    create_table :user_registers do |t|
      t.string :name
      t.string :email
      t.string :cadre_card
      t.string :password
      t.integer :steap_proces
      t.string :sex
      t.boolean :terms
      t.integer :phone

      t.timestamps
    end
  end
end
