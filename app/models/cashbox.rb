class Cashbox < ApplicationRecord
  belongs_to :pos, class_name: 'PointOfSale'
  belongs_to :account

  scope :on_day, ->(time = Time.zone.now) {where('cashboxes.created_at > ? and cashboxes.created_at < ?', time.beginning_of_day, time.end_of_day) }
  scope :sold, -> { where(kind: %w(cash card)) }
  scope :by_pos_id, ->(pos_id) { where(pos_id: pos_id) }
  scope :last_n_days, ->(n) { where('cashboxes.created_at > ?', (Time.zone.now - n.days).beginning_of_day) }
end
