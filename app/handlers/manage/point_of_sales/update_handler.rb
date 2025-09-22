class Manage::PointOfSales::UpdateHandler < ApplicationHandler
  params do
    integer :id, presence: true
  end

  def form_attributes
    { model: [:manage, point_of_sale] }
  end

  form do
    resource_model PointOfSale

    element :title do
      input(type: :text, class: 'form-control')
      output(type: :string, presence: true)
      label(class: 'col-4 col-form-label')
    end

    has_one :place do
      element :city do
        input(type: :text, class: 'form-control')
        output(type: :string, presence: true)
        label(class: 'col-4 col-form-label')
      end

      element :address do
        input(type: :text, class: 'form-control')
        output(type: :string, presence: true)
        label(class: 'col-4 col-form-label')
      end
    end

    def render_element(element)
      div(class: 'form-group row') do
        div(class: 'col-4 mb-3') do
          render_label(element)
        end
        div(class: 'col-8 mb-3') do
          render_input(element, class: element.tags[:errors] ? 'is-invalid' : '')
          render_inline_errors(element) if element.tags[:errors]
        end
      end
    end

    def render_submit
      div(class: 'form-group row') do
        div(class: 'd-grid col-4 mx-auto my-3') do
          super(class: 'btn btn-primary', 'data-disable-with' => 'Зберегти', value: 'Зберегти')
        end
      end
    end
  end

  finder :point_of_sale, -> { PointOfSale.find_by(id: params.id) }, validate_existence: true

  def call
    point_of_sale.update(form_params.to_h)
  end
end
