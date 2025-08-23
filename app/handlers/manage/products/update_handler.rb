class Manage::Products::UpdateHandler < ApplicationHandler
  form do
    element :title do
      input(type: :text, class: 'col-8 form-control')
      output(type: :string, presence: true)
      label(class: 'col-4 col-form-label')
    end

    has_many :variants do
      element :weight do
        input(type: :text, class: 'col-8 form-control')
        output(type: :string, presence: true)
        label(class: 'col-4 col-form-label')
      end
      element :price do
        input(type: :text, class: 'col-8 form-control')
        output(type: :string, presence: true)
        label(class: 'col-4 col-form-label')
      end
    end

    def render_input(element)
      div(class: 'col-8') do
        super
      end
    end

    def render_element(element)
      div(class: 'form-group row') do
        super
      end
    end

    def render_submit
      div(class: 'form-group row') do
        div(class: 'col-8 offset-4') do
          super(class: 'btn btn-primary', 'data-disable-with' => 'Зберегти', value: 'Зберегти')
        end
      end
    end
  end

  params do |handler_class|
    integer :id
    has :product, handler_class.form_definition.params_definition
  end

  finder :product, -> { Product.find_by(id: params.id) }, validate_existence: true
  finder :variants, -> { product.variants }, validate_existence: { base: true, message: 'No variants' }

  def call(response)
    ::ApplicationRecord.transaction do
      product.update!(title: title)
      variant.update!(weight: weight, price: price)
    rescue => e
      response.errors.add(:unprocessable_entity, e.message)
      raise ActiveRecord::Rollback
    end
  end

  memoize def form
    form_class.new(model: [:manage, product])
  end
end
