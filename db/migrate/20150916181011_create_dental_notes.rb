class CreateDentalNotes < ActiveRecord::Migration
  def change
    create_table :dental_notes do |t|
      t.integer :dental_record_id
      t.text :note
      t.text :new_treatment

      t.timestamps
    end
  end
end
