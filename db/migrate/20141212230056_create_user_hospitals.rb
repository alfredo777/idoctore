class CreateUserHospitals < ActiveRecord::Migration
  def change
    create_table :user_hospitals do |t|
      t.integer :user_id
      t.integer :hospital_id

      t.timestamps
    end
  end
end
