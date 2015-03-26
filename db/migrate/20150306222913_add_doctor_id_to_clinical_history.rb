class AddDoctorIdToClinicalHistory < ActiveRecord::Migration
  def change
    add_column :clinical_histories, :doctor_id, :integer
  end
end
