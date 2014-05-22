class CreateDiseases < ActiveRecord::Migration
  def change
    create_table :diseases do |t|
      t.string :name
      t.string :id_from_icd10

      t.timestamps
    end
  end
end
