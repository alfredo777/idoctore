class CreateAssistantPermissionings < ActiveRecord::Migration
  def change
    create_table :assistant_permissionings do |t|
      t.integer :office_assistant_assigned_doctor_id
      t.boolean :create_info_for_patient, default: false
      t.boolean :create_patient, default: true
      t.boolean :update_patient, default: true
      t.boolean :update_doctor, default: false
      t.boolean :create_cite, default: true
      t.boolean :assign_patient, default: true

      t.timestamps
    end
  end
end
