class Manage::Products::UpdateHandler < ApplicationHandler
  form Manage::Products::ModelForm

  params do
    integer :id, presence: true
  end

  finder :product, -> { Product.find_by(id: params.id) }, validate_existence: true

  def call
    product.update(form_params.to_h)
  end

  def destroy
    product.destroy
  end

  def form_attributes
    { model: [:manage, product] }
  end
end
