class Manage::AnalyticsController < ApplicationController
  before_action :authenticate_account!

  def index
    @sold_today = Cashbox.on_day.sold.select('sum(price_uah * quantity) as sold_amount').group('cashboxes.id').sum(&:sold_amount)

    @number_today = Stock.on_day.sold.select('sum(quantity) as sold_number').group('stocks.id').sum(&:sold_number)

    @stocks = ProductStocksQuery.new.all.first(7)

    transactions = PosCashQuery.new(last_days: 7).all
    @sell_data2 = []
    @sell_data = { labels: [], datasets: [] }
    transactions.group('title').pluck('title, pos_id').uniq.each do |title, pos_id|
      dataset = { label: title, data: [], background_color: "rgba(#{rand(255)}, #{rand(255)}, #{rand(255)}, 0.4)" }
      8.times.to_a.reverse.each do |d|
        time =  Time.zone.now - d.days
        report = PosCashQuery.new({on_day: time, pos_id: pos_id}, transactions).all
        dataset[:data] << (report.blank? ? 0 : report.sum(&:sold_amount))
        if d.zero?
          @sell_data2 << PosPerformance.new(report, dataset[:data].last, title)
        end
      end
      @sell_data[:datasets] << dataset
    end
    8.times.to_a.reverse.each do |d|
      time =  Time.zone.now - d.days
      @sell_data[:labels] << I18n.l(time, format: '%d/%m')
    end
  end
end
