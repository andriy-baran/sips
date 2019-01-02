class ProductStocksQuery
  def initialize(options = {}, relation = PosProductStock.includes(:pos, :product))
    @relation = relation
    @options = options
  end

  def all
    scope = filter_by_product(@relation, @options[:product_id])
    scope = filter_by_pos(scope, @options[:pos_id])
    scope.order(:on_hand)
  end

  private

  def filter_by_product(scope, product_id = nil)
    product_id.nil? ? scope : scope.by_product_id(product_id)
  end

  def filter_by_pos(scope, pos_id = nil)
    pos_id.nil? ? scope : scope.by_pos_id(pos_id)
  end
end
