module Manage::Accounts
  class SearchForm < ActionForm::Base
    element :email do
      input(type: :text, class: 'form-control', autocomplete: 'off')
      output(type: :string)
      label(class: 'col-4 col-form-label', text: 'Емейл')
    end

    element :full_name do
      input(type: :text, class: 'form-control', autocomplete: 'off')
      output(type: :string)
      label(class: 'col-4 col-form-label', text: 'Повне Ім\'я')
    end

    element :phone do
      input(type: :text, class: 'form-control', autocomplete: 'off')
      output(type: :string)
      label(class: 'col-4 col-form-label', text: 'Телефон')
    end

    element :pos_id do
      input(type: :select, class: 'form-control')
      output(type: :integer, normalize: ->(value) { !value.present? ? nil : value.to_i })
      label(class: 'col-4 col-form-label', text: 'Точка Продажу')
      options(PointOfSale.all.map { |pos| [pos.id, pos.title] }.unshift(['', 'Усі точки продажу']))
    end

    def render_submit
      div(class: 'form-group row') do
        div(class: 'd-grid col-4 mx-auto my-3') do
          super(class: 'btn btn-primary', 'data-disable-with' => 'Пошук', value: 'Пошук')
        end
        div(class: 'd-grid col-4 mx-auto my-3') do
          a(href: helpers.manage_accounts_path, class: 'btn btn-secondary') do
            'Скинути'
          end
        end
      end
    end
  end
end
