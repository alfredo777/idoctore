class AddInconsequentialToDiagnostic < ActiveRecord::Migration
  def change
    add_column :diagnostics, :inconsequential, :boolean
  end
end
