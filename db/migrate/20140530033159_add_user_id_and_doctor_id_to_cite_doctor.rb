class AddUserIdAndDoctorIdToCiteDoctor < ActiveRecord::Migration
  def change
    add_column :cite_doctors, :user_id, :integer
    add_column :cite_doctors, :doctor_id, :integer
  end
end
