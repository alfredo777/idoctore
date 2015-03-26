class CreatePhisicalExplorations < ActiveRecord::Migration
  def change
    create_table :phisical_explorations do |t|
      t.string :body_part
      t.text :notes
      t.integer :clinical_history_id

      t.timestamps
    end
  end
end
