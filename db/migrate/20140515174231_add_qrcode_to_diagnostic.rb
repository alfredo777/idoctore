class AddQrcodeToDiagnostic < ActiveRecord::Migration
  def change
    add_column :diagnostics, :qrcode, :string
  end
end
