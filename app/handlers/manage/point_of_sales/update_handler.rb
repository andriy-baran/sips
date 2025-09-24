class Manage::PointOfSales::UpdateHandler < ApplicationHandler
  url_params do
    integer :id, presence: true
  end

  def form_attributes
    { model: [:manage, point_of_sale] }
  end

  form Manage::PointOfSales::ModelForm

  finder :point_of_sale, -> { PointOfSale.find_by(id: url_params.id) }, validate_existence: true

  def call
    point_of_sale.update(form_params.to_h)
  end
end
