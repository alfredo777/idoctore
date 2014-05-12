class CreateDiagnostics < ActiveRecord::Migration
  def change
    create_table :diagnostics do |t|
      t.integer :user_id
      t.text :interrogation
      t.text :physical_examination
      t.text :diagnostic_or_clinical_problem
      t.text :list_of_laboratory_studies
      t.text :required_therapies
      t.text :suggested_treatments

      t.timestamps
    end
  end
end
