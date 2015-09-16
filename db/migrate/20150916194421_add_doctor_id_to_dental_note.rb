class AddDoctorIdToDentalNote < ActiveRecord::Migration
  def change
    add_column :dental_notes, :doctor_id, :integer
  end
end
