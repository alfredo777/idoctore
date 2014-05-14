class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :solictude
      t.boolean :accepted
      t.datetime :dateandour
      t.string :place

      t.timestamps
    end
  end
end
