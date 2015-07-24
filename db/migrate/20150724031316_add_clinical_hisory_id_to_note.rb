class AddClinicalHisoryIdToNote < ActiveRecord::Migration
  def change
    add_column :notes, :clinical_history_id, :integer
  end
end
