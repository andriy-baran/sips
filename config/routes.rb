Rails.application.routes.draw do
  devise_for :accounts, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  namespace :manage do
    resources :products
    resources :point_of_sales
    resources :accounts, except: %i(new create)
  end

  namespace :trade do
    resources :point_of_sales, only: :show
  end
end
