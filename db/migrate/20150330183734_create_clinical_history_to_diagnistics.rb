class CreateClinicalHistoryToDiagnistics < ActiveRecord::Migration
  def change
    create_table :clinical_history_to_diagnostics do |t|
      t.integer :diagnostic_id
      t.integer :clinical_history_id
      t.timestamps
    end
  end
end
