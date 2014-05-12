class AddChronicToDiagnostic < ActiveRecord::Migration
  def change
    add_column :diagnostics, :chronic, :boolean
  end
end
