class AddNotesToClinicalHistory < ActiveRecord::Migration
  def change
    add_column :clinical_histories, :note_pathology, :text
    add_column :clinical_histories, :note_no_pathology, :text
    add_column :clinical_histories, :note_family, :text
  end
end
