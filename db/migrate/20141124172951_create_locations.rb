class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :ip_address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
