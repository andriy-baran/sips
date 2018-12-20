class Stock < ApplicationRecord
 scope :this_day, -> {where('created_at > ? and created_at < ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day) }
 scope :sold_today, -> {where('kind = ?', 'sell').merge(Stock.this_day) }
 belongs_to :product
end
