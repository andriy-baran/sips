class Manage::AnalyticsController < ApplicationController
  before_action :authenticate_account!

  def index
    @sold_today = Cashbox.on_day.sold.select('sum(price_uah * quantity) as sold_amount').first.sold_amount

    @number_today = Stock.on_day.sold.select('sum(quantity) as sold_number').first.sold_number

    @stocks = Stock.includes(:pos, :product).on_day(Time.zone.now.yesterday).checkouted.order(:weight_kilogram).first(7)

    transactions = Cashbox.includes(:pos).sold.where('cashboxes.created_at > ?', (Time.zone.now - 7.days).beginning_of_day)

    @sell_data = { labels: [], datasets: [] }
    transactions.pluck('title, pos_id').uniq.each do |title, pos_id|
      dataset = { label: title, data: [], background_color: "rgba(#{rand(255)}, #{rand(255)}, #{rand(255)}, 0.4)" }
      8.times.to_a.reverse.each do |d|
        time =  Time.zone.now - d.days
        pos_transactions = transactions.group('pos_id, date(cashboxes.created_at)').select('sum(price_uah * quantity) as sold_amount, pos_id')
        sold_by_pos_on_day = pos_transactions.on_day(time).by_pos_id(pos_id).first
        dataset[:data] << sold_by_pos_on_day.sold_amount unless sold_by_pos_on_day.nil?
      end
      @sell_data[:datasets] << dataset
    end
    8.times.to_a.reverse.each do |d|
      time =  Time.zone.now - d.days
      @sell_data[:labels] << I18n.l(time, format: '%d/%m')
      transactions = Cashbox.sold.on_day(time)
    end
  end
end
