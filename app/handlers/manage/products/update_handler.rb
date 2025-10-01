class Manage::Products::UpdateHandler < ApplicationHandler
  form Manage::Products::ModelForm

  url_params do
    integer :id, presence: true
  end

  finder :product, -> { Product.find_by(id: url_params.id) }, validate_existence: true

  def on_validation_success
    call if current_action.update?
    destroy if current_action.destroy?
  end

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
