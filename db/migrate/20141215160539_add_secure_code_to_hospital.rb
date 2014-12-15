class AddSecureCodeToHospital < ActiveRecord::Migration
  def change
    add_column :hospitals, :secure_code, :string
  end
end
