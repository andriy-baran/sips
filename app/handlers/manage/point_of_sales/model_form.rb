class Manage::PointOfSales::ModelForm < EasyForm::Rails::Base
  include FormViews::HorizontalElement

  resource_model PointOfSale

  element :title do
    input(type: :text, class: 'form-control')
    output(type: :string, presence: true)
    label(class: 'col-4 col-form-label')

    def readonly?
      object.persisted?
    end
  end

  has_one :place, default: {} do
    include FormViews::HorizontalElement

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

  def render_submit
    div(class: 'form-group row') do
      div(class: 'd-grid col-4 mx-auto my-3') do
        super(class: 'btn btn-primary', 'data-disable-with' => 'Зберегти', value: 'Зберегти')
      end
    end
  end
end
