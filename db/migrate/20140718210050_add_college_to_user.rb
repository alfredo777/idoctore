class AddCollegeToUser < ActiveRecord::Migration
  def change
    add_column :users, :college, :string
  end
end
