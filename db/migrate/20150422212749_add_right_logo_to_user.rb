class AddRightLogoToUser < ActiveRecord::Migration
  def change
    add_column :users, :right_logo, :string
  end
end
