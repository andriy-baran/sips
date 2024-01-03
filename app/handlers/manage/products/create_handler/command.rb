class Manage::Products::CreateHandler
  class Command < SteelWheel::Command
    def add_to_stock!
      ::PointOfSale.find_each do |pos|
        ::PosProductStock.create!(pos_id: pos.id, product_id: new_product.id, on_hand: 0.0)
      end
    end

    def call(flow)
      ::ApplicationRecord.transaction do
        new_product.save!
        new_variant.save!
        add_to_stock!
      rescue => e
        flow.errors.add(:unprocessable_entity, e.message)
        raise ActiveRecord::Rollback
      end
    end
  end
end
