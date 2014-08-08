class AddPaymentMethodToUser < ActiveRecord::Migration
  def change
    add_column :users, :payment_method, :boolean, :default => false
  end
end
