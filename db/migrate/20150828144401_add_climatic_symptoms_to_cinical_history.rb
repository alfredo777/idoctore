class AddClimaticSymptomsToCinicalHistory < ActiveRecord::Migration
  def change
    add_column :clinical_histories, :climatic_symptoms, :text
  end
end
