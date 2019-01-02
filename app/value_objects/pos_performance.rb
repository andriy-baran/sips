class PosPerformance < Struct.new(:report, :total_uah, :pos_title)
  def total
    @total ||= get_total
  end

  def card_total
    @card_total ||= get_card_total
  end

  def cash_total
    @cash_total ||= get_cash_total
  end

  def seller_name
    @seller_name ||= get_seller_name
  end

  def <=>(other)
    total_uah <=> other.total_uah
  end

  private

  def get_total
    total = report.sum(&:sold_amount)
    (total.nil? ? '0 UAH' : "#{total} UAH").to_money.format
  end

  def get_card_total
    card_total = report.where(kind: 'card').sum(&:sold_amount)
    (card_total.nil? ? '0 UAH' : "#{card_total} UAH").to_money.format
  end

  def get_cash_total
    cash_total = report.where(kind: 'cash').sum(&:sold_amount)
    (cash_total.nil? ? '0 UAH' : "#{cash_total} UAH").to_money.format
  end

  def get_seller_name
    return 'Невідомо' if report.first.nil?
    report.first.account.full_name
  end
end
