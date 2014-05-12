class CreateClinicalAnalyses < ActiveRecord::Migration
  def change
    create_table :clinical_analyses do |t|
      t.string :title
      t.integer :user_id
      t.integer :diagnostic_id

      t.timestamps
    end
  end
end
