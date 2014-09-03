class AddSpecialismToUser < ActiveRecord::Migration
  def change
    add_column :users, :specialism, :text
  end
end
