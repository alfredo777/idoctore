class ClinicalHistoriesVitalSignsDropColumn < ActiveRecord::Migration
  def change
    remove_column :clinical_histories, :vital_sign_id
  end
end
