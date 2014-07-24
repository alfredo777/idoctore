class AddCadreCardToUser < ActiveRecord::Migration
  def change
    add_column :users, :cadre_card, :string
  end
end
