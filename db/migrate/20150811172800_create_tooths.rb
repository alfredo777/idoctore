class CreateTooths < ActiveRecord::Migration
  def change
    create_table :tooths do |t|
      t.integer :number
      t.boolean :top
      t.boolean :bottom
      t.boolean :left
      t.boolean :right
      t.integer :dental_record_id

      t.timestamps
    end
  end
end
