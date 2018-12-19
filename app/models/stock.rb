class Stock < ApplicationRecord
 scope :sold_today, -> {where('created_at > ? and created_at < ? and kind = ?', Time.now.midnight, Time.now.at_end_of_day, 'sell') }
 belongs_to :account
end
