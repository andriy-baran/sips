class Manage::Accounts::IndexHandler < ApplicationHandler
  def form_attributes
    { method: :get, action: helpers.manage_accounts_path }
  end

  form Manage::Accounts::SearchForm

  filter :email do |scope, value|
    scope.where('lower(email) like ?', "%#{value.downcase}%")
  end

  filter :full_name do |scope, value|
    scope.where('full_name ~* ?', "#{value.downcase}")
  end

  filter :phone do |scope, value|
    scope.where('lower(phone) like ?', "%#{value.downcase}%")
  end

  filter :pos_id do |scope, value|
    scope.where(pos_id: value) if value.present?
  end

  filterable def accounts
    Account.all
  end
end
