class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.integer :last_analysis
      t.integer :last_signs
      t.text :new_treatment

      t.timestamps
    end
  end
end
