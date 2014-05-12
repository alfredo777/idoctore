class CreateVitalSigns < ActiveRecord::Migration
  def change
    create_table :vital_signs do |t|
      t.integer :weight
      t.integer :blood_pressure_up
      t.integer :blood_pressure_down
      t.integer :pulse
      t.integer :height
      t.integer :breathing
      t.integer :temperature
      t.integer :user_id

      t.timestamps
    end
  end
end
