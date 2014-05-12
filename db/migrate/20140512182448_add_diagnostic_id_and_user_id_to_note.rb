class AddDiagnosticIdAndUserIdToNote < ActiveRecord::Migration
  def change
    add_column :notes, :diagnostic_id, :integer
    add_column :notes, :user_id, :integer
  end
end
