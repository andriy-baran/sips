module FormViews
  module HorizontalElement
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
  end

  module VerticalElement
    def render_element(element)
      div(class: 'form-group') do
        render_label(element)
        render_input(element, class: element.tags[:errors] ? 'is-invalid' : '')
        render_inline_errors(element) if element.tags[:errors]
      end
    end

    def render_inline_errors(element)
      div(class: 'invalid-feedback') do
        element.errors_messages.join(', ')
      end
    end
  end
end