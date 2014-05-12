class AddSeriousToDiagnostic < ActiveRecord::Migration
  def change
    add_column :diagnostics, :serious, :boolean
  end
end
