class AddDentalClinicalHistoryToUser < ActiveRecord::Migration
  def change
    add_column :users, :dental_clinical_history, :boolean, default: false
    add_column :users, :dental_module, :boolean, default: false
    add_column :users, :homeopatic_clinical_history, :boolean, default: false
    add_column :users, :acupulture_clinical_history, :boolean, default: false
    add_column :users, :acupulture_module, :boolean, default: false
    add_column :users, :normative_clinical_history, :boolean, default: true

  end
end
