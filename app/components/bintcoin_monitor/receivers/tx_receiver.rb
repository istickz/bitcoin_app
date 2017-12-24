module BintcoinMonitor
  module Receivers
    class TxReceiver
      def self.call(tx_hash)
        ActiveRecord::Base.transaction do
          tx = Tx.create(
            tx_hash: tx_hash['hash'],
            ver: tx_hash['ver'],
            vin_sz: tx_hash['vin_sz'],
            vout_sz: tx_hash['vout_sz'],
            lock_time: tx_hash['lock_time'],
            size: tx_hash['size']
          )
          tx_hash['in'].each do |tin|
            tx.tx_ins.where(prevout_hash: tin.dig(:prev_out, :hash)).first_or_create do |record|
              record.n = tin.dig(:prev_out, :n)
              record.script_sig = tin['scriptSig']
            end
          end


          tx_hash['out'].each do |tout|
            tx.tx_outs.create(
              value: tout['value'],
              script_pubkey: tout['scriptPubKey']
            )
          end
        end
      end
    end
  end
end
