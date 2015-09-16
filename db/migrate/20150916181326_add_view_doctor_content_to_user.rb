class AddViewDoctorContentToUser < ActiveRecord::Migration
  def change
    add_column :users, :view_doctor_content, :boolean, default: true
  end
end
