class AddHomeopaticModulesToClinicalHistory < ActiveRecord::Migration
  def change
    add_column :clinical_histories, :sweting, :text
    add_column :clinical_histories, :appetite, :text
    add_column :clinical_histories, :thirst, :text
    add_column :clinical_histories, :desires_food_or_food_refusal, :text
    add_column :clinical_histories, :sleep, :text
    add_column :clinical_histories, :sexuality, :text
    add_column :clinical_histories, :skin_and_appendages, :text
    add_column :clinical_histories, :musculoskeletal_apparatus, :text
    add_column :clinical_histories, :endocrine_system, :text
    add_column :clinical_histories, :hematopoietic_system, :text
    add_column :clinical_histories, :digestive_system, :text
    add_column :clinical_histories, :genitourinary_system, :text
    add_column :clinical_histories, :nervous_system, :text
    add_column :clinical_histories, :cardiovascular_system, :text
  end
end
