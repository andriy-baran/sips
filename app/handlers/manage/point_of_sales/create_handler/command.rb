class Manage::PointOfSales::CreateHandler
  class Command < SteelWheel::Command
    def call(_flow)
      pos = new_pos.tap(&:save!)
      ::Product.all.each do |product|
        ::PosProductStock.create(pos_id: pos.id, product_id: product.id, on_hand: 0.0)
      end
    end
  end
end
