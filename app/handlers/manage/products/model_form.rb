module Manage
  module Products
    class ModelForm < EasyForm::Rails::Base
      resource_model Product

      element :title do
        input(type: :text, class: 'form-control')
        output(type: :string, presence: true)
        label(class: 'col-4 col-form-label')
      end

      has_many :variants, default: [{}] do
        subform do
          element :weight do
            input(type: :text, class: 'form-control')
            output(type: :string, presence: true, format: { with: /\A[0-9]+\s[g|kg]\z/ }, normalize: ->(v) { v.sub('gram', 'g') })
            label(class: 'col-4 col-form-label')
          end

          element :price do
            input(type: :text, class: 'form-control')
            output(type: :string, presence: true)
            label(class: 'col-4 col-form-label')

            def value
              super&.format(symbol: 'UAH')
            end
          end

          def render_element(element)
            render_label(element)
            render_input(element, class: element.tags[:errors] ? 'is-invalid' : '')
            if element.tags[:errors]
              div(class: 'invalid-feedback') do
                element.errors_messages.join(', ')
              end
            end
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
    end
  end
end