class CreateClinicalHistories < ActiveRecord::Migration
  def change
    create_table :clinical_histories do |t|
      t.integer :user_id
      t.integer :hospital_id
      
      t.timestamps
    end
  end
end
