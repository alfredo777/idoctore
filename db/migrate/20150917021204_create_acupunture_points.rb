class CreateAcupunturePoints < ActiveRecord::Migration
  def change
    create_table :acupunture_points do |t|
      t.integer :acupunture_id
      t.string :x_axis
      t.string :y_axis
      t.string :name
      t.text :note
      t.string :color

      t.timestamps
    end
  end
end
