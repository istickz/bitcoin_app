class Tx < ApplicationRecord
  paginates_per 50
  has_and_belongs_to_many :blocks
  has_many :tx_ins
  has_many :tx_outs

  def to_param
    tx_hash
  end
end

