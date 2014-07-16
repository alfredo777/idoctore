class AddAssignedToCupon < ActiveRecord::Migration
  def change
    add_column :cupons, :assigned, :integer
  end
end
