class AddFindidToAcupunturePoint < ActiveRecord::Migration
  def change
    add_column :acupunture_points, :findid, :string
  end
end
