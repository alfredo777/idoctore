class AddDoctorIdToDentalRecord < ActiveRecord::Migration
  def change
    add_column :dental_records, :doctor_id, :integer
  end
end
