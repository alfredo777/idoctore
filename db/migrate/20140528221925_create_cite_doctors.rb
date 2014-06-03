class CreateCiteDoctors < ActiveRecord::Migration
  def change
    create_table :cite_doctors do |t|
      t.datetime :init_time
      t.datetime :finish_time
      t.text :request
      t.boolean :confirmed_by_doctor

      t.timestamps
    end
  end
end
