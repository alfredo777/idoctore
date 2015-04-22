class AddLeftLogoToUser < ActiveRecord::Migration
  def change
    add_column :users, :left_logo, :string
  end
end
