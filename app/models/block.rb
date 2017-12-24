class Block < ApplicationRecord
  has_and_belongs_to_many :txes
end
