class AddAcceptedRequestToDoctorPatients < ActiveRecord::Migration
  def change
    add_column :doctor_patients, :accepted_request, :boolean, :default => false
  end
end
