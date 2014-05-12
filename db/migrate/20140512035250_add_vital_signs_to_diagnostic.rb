class AddVitalSignsToDiagnostic < ActiveRecord::Migration
  def change
    add_column :diagnostics, :vital_signs, :integer
  end
end
