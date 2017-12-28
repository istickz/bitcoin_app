class TxOut < ApplicationRecord
  belongs_to :tx

  def address_type
    return 'NONE' unless address.present?
    case address
      when /^1/
        'P2PKH'
      when /^3/
        'P2SH'
      when /^bc1/
        'Bech32'
      else
        'UNKNOWN'
    end
  end

  def btc_value
    sprintf "%.8f", (value.to_f / 10**8)
  end
end
