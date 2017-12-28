class CreateBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :blocks do |t|
      t.binary :block_hash
      t.integer :ver
      t.binary :prev_block
      t.binary :mrkl_root
      t.integer :time
      t.integer :bits, limit: 5
      t.integer :nonce, limit: 5
      t.integer :n_tx
      t.integer :size
      t.timestamps
    end
  end
end
