module Manage::Accounts
  class ModelForm < ActionForm::Rails::Base
    include FormViews::HorizontalElement

    resource_model Account

    element :full_name do
      input(type: :text, class: 'form-control')
      output(type: :string, presence: true)
      label(class: 'col-4 col-form-label', text: 'Повне Ім\'я')
    end

    element :email do
      input(type: :email, class: 'form-control')
      output(type: :string, presence: true)
      label(class: 'col-4 col-form-label', text: 'Емейл')
    end

    element :phone do
      input(type: :text, class: 'form-control')
      output(type: :string, presence: true)
      label(class: 'col-4 col-form-label', text: 'Телефон')
    end

    element :pos_id do
      input(type: :select, class: 'form-control')
      output(type: :integer, presence: true)
      label(class: 'col-4 col-form-label', text: 'Точка Продажу')
      options(PointOfSale.all.map { |pos| [pos.id, pos.title] })
    end

    element :role do
      input(type: :select, class: 'form-control')
      output(type: :string, presence: true)
      label(class: 'col-4 col-form-label', text: 'Роль')
      options([['seller', 'Продавець' ], ['manager', 'Менеджер']])
    end

    element :password do
      input(type: :password, autocomplete: 'new-password', class: 'form-control')
      output(type: :string)
      label(class: 'col-4 col-form-label', text: 'Пароль')

      def detached?
        true
      end

      def render?
        %w[create new].include?(owner_current_action)
      end
    end

    element :password_confirmation do
      input(type: :password, autocomplete: 'off', class: 'form-control')
      output(type: :string)
      label(class: 'col-4 col-form-label', text: 'Повтор Пароля')

      def detached?
        true
      end

      def render?
        %w[create new].include?(owner_current_action)
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
