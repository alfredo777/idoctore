class CreateAcupunctures < ActiveRecord::Migration
  def change
    create_table :acupunctures do |t|
      t.integer :user_id
      t.integer :doctor_id
      t.integer :clinical_history_id
      t.text :note

      t.timestamps
    end
  end
end
