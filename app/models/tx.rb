class Tx < ApplicationRecord
  has_and_belongs_to_many :blocks
  has_many :tx_ins
  has_many :tx_outs
end
