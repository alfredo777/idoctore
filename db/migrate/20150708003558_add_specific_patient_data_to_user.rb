class AddSpecificPatientDataToUser < ActiveRecord::Migration
  def change
   add_column :users, :ethnic_group, :string
   add_column :users, :nationality, :string
   add_column :users, :marital_status, :string
   add_column :users, :occupation, :string
   add_column :users, :birthplace, :string
   add_column :users, :place_of_residence, :string
   add_column :users, :home, :text
   add_column :users, :person_in_charge, :string
   add_column :users, :religion, :string
   add_column :users, :sexual_preference, :string
   add_column :users, :number_of_sexual_partners, :integer
  end
end
