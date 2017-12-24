class CreateTxIns < ActiveRecord::Migration[5.1]
  def change
    create_table :tx_ins do |t|
      t.integer :tx_id,  limit: 5
      t.binary :prevout_hash
      t.integer :n
      t.binary :script_sig
      t.timestamps
    end
  end
end
