class AddMentalSymptomsToClinicalHistory < ActiveRecord::Migration
  def change
    add_column :clinical_histories, :mental_symptoms, :text
  end
end
