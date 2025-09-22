class Manage::Products::IndexHandler < ApplicationHandler
  def form_attributes
    { method: :get, action: helpers.manage_products_path, params: form_params }
  end

  form EasyForm::Base do
    element :title do
      input(type: :text, class: 'form-control')
      output(type: :string)
      label(class: 'col-4 col-form-label')
    end

    def render_submit
      div(class: 'form-group row') do
        div(class: 'd-grid col-4 mx-auto my-3') do
          super(class: 'btn btn-primary', 'data-disable-with' => 'Пошук', value: 'Пошук')
        end
      end
    end
  end

  filter :title do |scope, value|
    scope.where('lower(title) like ?', "%#{value.downcase}%")
  end

  filterable def products
    Product.includes(:variants)
  end
end
