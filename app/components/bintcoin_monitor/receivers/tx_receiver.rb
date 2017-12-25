module BintcoinMonitor
  module Receivers
    class TxReceiver
      def self.call(tx_hash)
        tx = Tx.create(
          tx_hash: tx_hash['hash'],
          ver: tx_hash['ver'],
          vin_sz: tx_hash['vin_sz'],
          vout_sz: tx_hash['vout_sz'],
          lock_time: tx_hash['lock_time'],
          size: tx_hash['size']
        )

        tx_hash['in'].each do |tin|
          tx.tx_ins.create(
            prevout_hash: tin.dig('prev_out', 'hash'),
            n: tin.dig('prev_out', 'n'),
            script_sig: tin['scriptSig'],
          )
        end

        tx_hash['out'].each do |tout|
          tx.tx_outs.create(
            value: tout['value'].to_f * 10**8,
            script_pubkey: tout['scriptPubKey'],
            address: tout['address']
          )
        end
        tx
      end
    end
  end
end
