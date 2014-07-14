class AddUserIdAndCreatorIdToSingleFile < ActiveRecord::Migration
  def change
    add_column :single_files, :user_id, :integer
    add_column :single_files, :creator_id, :integer
  end
end
