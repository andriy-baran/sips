class PointOfSale < ApplicationRecord
  belongs_to :place
  has_many :accounts
end
