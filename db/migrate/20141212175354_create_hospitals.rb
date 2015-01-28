class CreateHospitals < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :password
      t.string :salt
      t.integer :phone

      t.timestamps
    end
  end
end
