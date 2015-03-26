class CreateFamilialDiseases < ActiveRecord::Migration
  def change
    create_table :familial_diseases do |t|
      t.string :name
      t.integer :clinical_history_id
      t.string :category
      t.timestamps
    end
  end
end
