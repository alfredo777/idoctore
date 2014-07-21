class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.integer :user_id
      t.string :name
      t.string :logo_string
      t.text :study_or_do
      t.boolean :recipe_appears
      t.boolean :appears_in_diagnostic
      t.timestamps
    end
  end
end
