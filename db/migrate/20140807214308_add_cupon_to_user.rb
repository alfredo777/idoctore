class AddCuponToUser < ActiveRecord::Migration
  def change
    add_column :users, :cupon, :string
    add_column :users, :validity, :date
  end
end
