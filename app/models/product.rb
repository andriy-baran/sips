class Product < ApplicationRecord
  has_many :variants, dependent: :destroy
  has_many :product_stocks, class_name: 'PosProductStock', foreign_key: :product_id
  has_many :checkouts, -> { where(kind: 'checkout').order(created_at: :desc) }, class_name: 'Stock'
  has_many :checkins, -> { where(kind: 'checkin').order(created_at: :desc) }, class_name: 'Stock'
  has_many :checkins, -> { where(kind: 'checkin').order(created_at: :desc) }, class_name: 'Stock'

  accepts_nested_attributes_for :variants, allow_destroy: true
end
