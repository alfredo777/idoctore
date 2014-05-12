class AddOwnerByToVitalSign < ActiveRecord::Migration
  def change
    add_column :vital_signs, :owner_by, :integer
  end
end
