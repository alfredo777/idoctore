class AddVitalsignsToClinicalHistory < ActiveRecord::Migration
  def change
    add_column :clinical_histories, :vital_sign_id, :integer
  end
end
