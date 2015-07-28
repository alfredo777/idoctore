class AddHabitusExteriorToClinicalHistory < ActiveRecord::Migration
  def change
    add_column :clinical_histories, :habitus_exterior, :text
  end
end
