module BintcoinMonitor
  module Receivers
    class BlockReceiver
      def self.call(b_hash)

        ActiveRecord::Base.transaction do
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
          tx_hash.each_with_index do |tx_hash|
            tx = block.txes.where(tx_hash: tx_hash['hash']).first_or_create do |tx|
              tx.ver = tx_hash['ver']
              tx.vin_sz = tx_hash['vin_sz']
              tx.vout_sz = tx_hash['vout_sz']
              tx.lock_time = tx_hash['lock_time']
              tx.size = tx_hash['size']
            end

            tx_hash['in'].each do |tin|
              tx.tx_ins.where(prevout_hash: tin.dig(:prev_out, :hash)).first_or_create do |record|
                record.n = tin.dig(:prev_out, :n)
                record.script_sig = tin['scriptSig']
              end
            end

            tx_hash['out'].each do |tout|
              tx.tx_outs.find_or_create_by(
                value: tout['value'],
                script_pubkey: tout['scriptPubKey']
              )
            end
          end
        end
      end
    end
  end
end
