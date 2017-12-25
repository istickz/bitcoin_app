class AddIndices < ActiveRecord::Migration[5.1]
  def change
    add_index :blocks_txes, :block_id
    add_index :blocks_txes, :tx_id
    add_index :blocks, :block_hash, unique: true
    add_index :txes, :tx_hash, unique: true
  end
end
