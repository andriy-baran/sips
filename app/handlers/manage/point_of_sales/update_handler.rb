class Manage::PointOfSales::UpdateHandler < ApplicationHandler
  params do
    integer :id, presence: true
    has :point_of_sale, presence: true do
      string :title, presence: true
      has :place_attributes do
        string :city, presence: true
        string :address, presence: true
        integer :id, presence: true
      end
    end
  end

  finder :point_of_sale, -> { PointOfSale.find_by(id: params.id) }, validate_existence: true

  def call
    point_of_sale.update(params.point_of_sale.to_h)
  end
end
