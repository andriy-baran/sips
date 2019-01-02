class PosCashQuery
  def initialize(options = {}, relation = Cashbox.includes(:pos).sold)
    @relation = relation
    @options = options
  end

  def all
    scope = fetch_period(@relation, @options[:last_days])
    scope = filter_by_pos(scope, pos_id = @options[:pos_id])
    scope = filter_by_day(scope, on_day = @options[:on_day])
    scope
      .group('pos_id, date(cashboxes.created_at), cashboxes.id')
      .select('cashboxes.*, sum(price_uah * quantity) as sold_amount')
  end

  private

  def fetch_period(scope, last_days = nil)
    last_days.nil? ? scope : scope.last_n_days(last_days)
  end

  def filter_by_pos(scope, pos_id = nil)
    pos_id.nil? ? scope : scope.by_pos_id(pos_id)
  end

  def filter_by_day(scope, on_day = nil)
    on_day.nil? ? scope : scope.on_day(on_day)
  end
end
