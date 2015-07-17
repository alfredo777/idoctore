class AddBloodTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :blood_type, :string
  end
end
