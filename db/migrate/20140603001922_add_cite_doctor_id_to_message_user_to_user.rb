class AddCiteDoctorIdToMessageUserToUser < ActiveRecord::Migration
  def change
    add_column :message_user_to_users, :cite_doctor_id, :integer
    add_column :message_user_to_users, :message, :text
  end
end
