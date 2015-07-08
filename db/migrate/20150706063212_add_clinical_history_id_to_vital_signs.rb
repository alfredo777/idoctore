class AddClinicalHistoryIdToVitalSigns < ActiveRecord::Migration
  def change
    add_column :vital_signs, :clinical_history_id, :integer
  end
end
