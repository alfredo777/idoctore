class AddAcupunctureIdToAcupunturePoint < ActiveRecord::Migration
  def change
    add_column :acupunture_points, :acupuncture_id, :integer
    remove_column :acupunture_points, :acupunture_id
  end
end
