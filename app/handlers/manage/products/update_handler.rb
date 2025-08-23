class Manage::Products::UpdateHandler < ApplicationHandler
  form do
    self.scope = :product

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

  params do
    integer :id, presence: true
  end

  finder :product, -> { Product.find_by(id: params.id) }, validate_existence: true

  def call
    product.update(form_params.to_h)
  end

  def form_attributes
    { model: [:manage, product], id: helpers.dom_id(product) }
  end

  # def on_preconditions_failure
  #   product.assign_attributes(params.product.to_h)
  #   super
  # end
end
