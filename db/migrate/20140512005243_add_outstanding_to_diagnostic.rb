class AddOutstandingToDiagnostic < ActiveRecord::Migration
  def change
    add_column :diagnostics, :outstanding, :boolean
  end
end
