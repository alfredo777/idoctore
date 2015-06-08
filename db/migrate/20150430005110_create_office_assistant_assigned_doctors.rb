class CreateOfficeAssistantAssignedDoctors < ActiveRecord::Migration
  def change
    create_table :office_assistant_assigned_doctors do |t|
      t.integer :office_assistant_id
      t.integer :user_id

      t.timestamps
    end
  end
end
