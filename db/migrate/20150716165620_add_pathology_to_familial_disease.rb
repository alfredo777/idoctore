class AddPathologyToFamilialDisease < ActiveRecord::Migration
  def change
    add_column :familial_diseases, :pathology, :integer
    add_column :familial_diseases, :genealogy, :string
  end
end
