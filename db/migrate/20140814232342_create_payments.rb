class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :payment_global
      t.integer :bank_commission
      t.integer :final_comission
      t.date :init
      t.date :expire
      t.boolean :comissionpay
      t.string :seller_code
      t.string :method
      t.string :token_pay

      t.timestamps
    end
  end
end
