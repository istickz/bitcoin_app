class Block < ApplicationRecord
  paginates_per 50
  has_and_belongs_to_many :txes
end
