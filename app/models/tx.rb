class Tx < ApplicationRecord
  paginates_per 50
  has_and_belongs_to_many :blocks
  has_many :tx_ins
  has_many :tx_outs

  def to_param
    tx_hash
  end

  def to_hash
    h = {
      hash: tx_hash,
      ver: ver,
      vin_sz: vin_sz,
      vout_sz: vout_sz,
      lock_time: lock_time,
      size: size
    }

    h[:in] = tx_ins.map do |tx_in|
      tx_in_h = {
        prev_out: {
          hash: tx_in.prevout_hash,
          n: tx_in.n
        },
        scriptSig: tx_in.script_sig,
      }
      tx_in_h[:sequence] = tx_in.sequence if tx_in.sequence.present?
      tx_in_h
    end

    h[:out] = tx_outs.map do |tx_out|
      {
        value: tx_out.btc_value,
        scriptPubKey: tx_out.script_pubkey,
      }
    end

    HashWithIndifferentAccess.new(h)
  end
end
