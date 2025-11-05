class Manage::Accounts::CreateHandler < ApplicationHandler
  form Manage::Accounts::ModelForm do
    params do
      validates :password, presence: true
      validates :password_confirmation, presence: true, confirmation: true
    end
  end

  verify memoize def account
    Account.new(form_params.to_h)
  end

  def form_attributes
    { model: [:manage, account] }
  end

  def on_validation_success
    call if current_action.create?
  end

  def call
    account.save
  end
end
