class AddClassActionTooth < ActiveRecord::Migration
  def change
    add_column :tooths, :class_action_top, :string
    add_column :tooths, :class_action_bottom, :string
    add_column :tooths, :class_action_left, :string
    add_column :tooths, :class_action_right, :string
    add_column :tooths, :class_action_center, :string
  end
end
