class AddOwnerByToDiagnostic < ActiveRecord::Migration
  def change
    add_column :diagnostics, :owner_by, :integer
  end
end
