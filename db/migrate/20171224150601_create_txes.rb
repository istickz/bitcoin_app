class CreateTxes < ActiveRecord::Migration[5.1]
  def change
    create_table :txes do |t|
      t.binary :tx_hash
      t.integer :ver
      t.integer :vin_sz
      t.integer :vout_sz
      t.integer :lock_time
      t.integer :size

      t.timestamps
    end
  end
end
