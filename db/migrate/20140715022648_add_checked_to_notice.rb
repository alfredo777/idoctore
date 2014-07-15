class AddCheckedToNotice < ActiveRecord::Migration
  def change
    add_column :notices, :checked, :boolean
  end
end
