class AddInterviewToClinicalHistory < ActiveRecord::Migration
  def change
    add_column :clinical_histories, :interview, :text
    add_column :clinical_histories, :diagnostic, :text
    add_column :clinical_histories, :suffering, :text
    add_column :clinical_histories, :diagnostic_aux, :text
    add_column :clinical_histories, :terapeutic_use, :text

  end
end
