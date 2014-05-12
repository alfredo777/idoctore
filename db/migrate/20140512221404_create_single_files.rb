class CreateSingleFiles < ActiveRecord::Migration
  def change
    create_table :single_files do |t|
      t.string :name
      t.string :archive
      t.string :pass

      t.timestamps
    end
  end
end
