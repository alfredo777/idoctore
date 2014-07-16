class AddPrintingToCupon < ActiveRecord::Migration
  def change
    add_column :cupons, :printing, :string
    add_column :cupons, :manager_user_id, :integer
  end
end
