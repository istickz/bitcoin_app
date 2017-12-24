class CreateTxOuts < ActiveRecord::Migration[5.1]
  def change
    create_table :tx_outs do |t|
      t.integer :tx_id,  limit: 5
      t.integer :value,  limit: 5
      t.binary :script_pubkey
      t.timestamps
    end
  end
end
