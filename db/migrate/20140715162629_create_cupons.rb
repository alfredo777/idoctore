class CreateCupons < ActiveRecord::Migration
  def change
    create_table :cupons do |t|
      t.string :institution
      t.string :indentifier_random
      t.boolean :used
      t.integer :user_id

      t.timestamps
    end
  end
end
