class AddFindidToAcupunture < ActiveRecord::Migration
  def change
    add_column :acupunctures, :findid, :string
  end
end
