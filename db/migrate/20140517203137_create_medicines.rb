class CreateMedicines < ActiveRecord::Migration
  def change
    create_table :medicines do |t|
      t.string :name
      t.string :laboratoy
      t.text :indications
      t.date :init_date
      t.date :finish_date

      t.timestamps
    end
  end
end
