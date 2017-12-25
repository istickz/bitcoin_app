module BintcoinMonitor
  module Receivers
    class BlockReceiver
      def self.call(b_hash)
        block = Block.create(
          block_hash: b_hash['hash'],
          ver: b_hash['ver'],
          prev_block: b_hash['prev_block'],
          mrkl_root: b_hash['mrkl_root'],
          time: b_hash['time'],
          bits: b_hash['bits'],
          nonce: b_hash['nonce'],
          n_tx: b_hash['n_tx'],
          size: b_hash['size']
        )

        tx_hash = b_hash['tx']
        tx_hash.each do |tx_hash|
          tx = TxReceiver.call(tx_hash)
          block.txes << tx
        end

        block
      end
    end
  end
end
