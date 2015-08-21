class AddCenterToTooth < ActiveRecord::Migration
  def change
    add_column :tooths, :center, :boolean
    add_column :tooths, :problem, :string
    add_column :tooths, :note, :text
  end
end
