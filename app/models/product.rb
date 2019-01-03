class Product < ApplicationRecord
  has_one :variant, dependent: :destroy
  has_many :checkouts, -> { where(kind: 'checkout').order(created_at: :desc) }, class_name: 'Stock'
  has_many :checkins, -> { where(kind: 'checkin').order(created_at: :desc) }, class_name: 'Stock'
  has_many :checkins, -> { where(kind: 'checkin').order(created_at: :desc) }, class_name: 'Stock'
end
