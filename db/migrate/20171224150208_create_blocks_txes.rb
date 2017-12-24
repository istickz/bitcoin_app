class CreateBlocksTxes < ActiveRecord::Migration[5.1]
  def change
    create_table :blocks_txes do |t|
      t.integer :block_id
      t.integer :tx_id, limit: 5

      t.timestamps
    end
  end
end
