class AddPriceToCupon < ActiveRecord::Migration
  def change
    add_column :cupons, :price, :integer
  end
end
