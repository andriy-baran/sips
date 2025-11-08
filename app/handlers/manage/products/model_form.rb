module Manage
  module Products
    class ModelForm < ActionForm::Rails::Base
      resource_model Product

      element :title do
        input(type: :text, class: 'form-control')
        output(type: :string, presence: true)
        label(class: 'col-4 col-form-label')
      end

      many :variants, default: [{}] do
        subform do
          # include FormViews::VerticalElement

          element :weight_value do
            input(type: :text, class: 'form-control')
            output(type: :string, presence: true, numericality: true)
            label(display: false)
            tags(group: :weight)
          end

          element :weight_unit do
            input(type: :select, class: 'form-control')
            output(type: :string, presence: true, inclusion: { in: ['g', 'kg'] })
            label(display: false)
            options([['g', 'грам'], ['kg', 'кілограм']])
            tags(group: :weight)
          end

          element :price_value do
            input(type: :text, default: 0.0, class: 'form-control')
            output(type: :string, presence: true, numericality: true)
            label(display: false)
            tags(group: :price)
          end

          element :price_currency do
            input(type: :select, class: 'form-control')
            output(type: :string, presence: true, inclusion: { in: ['UAH', 'USD', 'EUR'] })
            label(display: false)
            options([['UAH', 'грн'], ['USD', 'usd'], ['EUR', 'eur']])
            tags(group: :price)
          end

          def render_elements
            elements = elements_instances.select(&:render?)
            weight_elements = elements.select { |element| element.tags[:group] == :weight }
            weight_has_errors = weight_elements.any? { |element| element.tags[:errors] }
            div(class: 'mb-3') do
              div(class: 'input-group') do
                span(class: 'input-group-text') do
                  'Вага'
                end
                weight_elements.map do |element|
                  render_input(element, class: element.tags[:errors] ? 'is-invalid' : '')
                end
              end
              if weight_has_errors
                div(class: 'invalid-feedback d-block') do
                  weight_elements.map(&:errors_messages).flatten.join(', ')
                end
              end
            end
            weight_elements.each { |element| elements.delete(element) }
            price_elements = elements.select { |element| element.tags[:group] == :price }
            price_has_errors = price_elements.any? { |element| element.tags[:errors] }
            div(class: 'mb-3') do
              div(class: 'input-group') do
                span(class: 'input-group-text') do
                  'Ціна'
                end
                price_elements.map do |element|
                  render_input(element, class: element.tags[:errors] ? 'is-invalid' : '')
                end
              end
              if price_has_errors
                div(class: 'invalid-feedback d-block') do
                  price_elements.map(&:errors_messages).flatten.join(', ')
                end
              end
            end
            price_elements.each { |element| elements.delete(element) }
            super(elements)
          end
        end

        def render_subform(subform)
          div(class: 'col') do
            div(class: 'mb-3 card h-100') do
              div(class: 'card-body') do
                super
                render_remove_subform_button(class: 'mt-3 btn btn-danger btn-block') do
                  'Remove'
                end
              end
            end
          end
        end
      end

      def render_many_subforms(subforms)
        fieldset do
          legend { 'Варіанти' }
          div(class: 'row row-cols-1 row-cols-md-3', id: 'variants') do
            super
            div(class: 'col') do
              render_new_subform_button(class: 'btn btn-success btn-block', 'data-insert-before-selector' => '#variants .col:last-child') do
                "Add #{subforms.name.to_s.singularize}"
              end
            end
          end
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

      def render_inline_errors(element)
        div(class: 'invalid-feedback') do
          element.errors_messages.join(', ')
        end
      end

      def render_submit
        div(class: 'form-group row') do
          div(class: 'd-grid col-4 mx-auto my-3') do
            super(class: 'btn btn-primary', 'data-disable-with' => 'Зберегти', value: 'Зберегти')
          end
        end
      end

      params do
        variants_attributes_schema do
          def weight
            "#{weight_value} #{weight_unit}"
          end

          def price
            "#{price_value} #{price_currency}".to_money
          end

          def to_h
            result = super
            result[:weight] = weight
            result.delete(:weight_value)
            result.delete(:weight_unit)
            result[:price] = price
            result.delete(:price_value)
            result.delete(:price_currency)
            result
          end
        end
      end
    end
  end
end