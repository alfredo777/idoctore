class CreatePathologicalAntecedents < ActiveRecord::Migration
  def change
    create_table :pathological_antecedents do |t|
      t.string :name
      t.text :note
      t.integer :clinical_history_id

      t.timestamps
    end
  end
end
