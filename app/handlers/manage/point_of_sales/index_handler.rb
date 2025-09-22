class Manage::PointOfSales::IndexHandler < ApplicationHandler
  def form_attributes
    { method: :get, action: helpers.manage_point_of_sales_path, params: form_params }
  end

  form EasyForm::Base do
    element :city do
      input(type: :select, class: 'form-control')
      output(type: :string)
      label(class: 'col-4 col-form-label')
      options(Place.group(:city).pluck(:city, :city).unshift(['', 'Усі міста']))
    end

    def render_submit
      div(class: 'form-group row') do
        div(class: 'd-grid col-4 mx-auto my-3') do
          super(class: 'btn btn-primary', 'data-disable-with' => 'Пошук', value: 'Пошук')
        end
      end
    end
  end

  filter :city do |scope, value|
    scope.where(places: { city: value })
  end

  filterable def point_of_sales
    PointOfSale.includes(:place)
  end

  def call
    # NOOP
  end
end
