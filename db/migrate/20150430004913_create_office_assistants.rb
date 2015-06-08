class CreateOfficeAssistants < ActiveRecord::Migration
  def change
    create_table :office_assistants do |t|
      t.string :name
      t.string :password
      t.string :email
      t.string :phone
      t.integer :organization_id
      t.integer :hospital_id

      t.timestamps
    end
  end
end
