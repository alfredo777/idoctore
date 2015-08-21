class CreateDentalRecords < ActiveRecord::Migration
  def change
    create_table :dental_records do |t|
      t.integer :user_id
      t.integer :clinical_history_id
      t.text :note

      t.timestamps
    end
  end
end
