class Manage::Accounts::UpdateHandler < ApplicationHandler
  form Manage::Accounts::ModelForm

  url_params do
    integer :id, presence: true
  end

  finder :account, -> { Account.find_by(id: url_params.id) }, validate_existence: true

  def on_validation_success
    call if current_action.update?
    destroy if current_action.destroy?
  end

  def call
    account.update(form_params.to_h)
  end

  def destroy
    account.destroy
  end

  def form_attributes
    { model: [:manage, account] }
  end
end

