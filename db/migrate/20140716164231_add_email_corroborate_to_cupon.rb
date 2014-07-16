class AddEmailCorroborateToCupon < ActiveRecord::Migration
  def change
    add_column :cupons, :email_corroborate, :string
  end
end
