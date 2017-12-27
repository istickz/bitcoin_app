class CreateWallets < ActiveRecord::Migration[5.1]
  def change
    create_table :wallets do |t|
      t.string :address
      t.text :privkey
      t.text :pubkey

      t.timestamps
    end
  end
end
