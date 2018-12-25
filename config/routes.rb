Rails.application.routes.draw do
  devise_for :accounts, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  namespace :manage do
    resources :products
    resources :point_of_sales
    resources :accounts
    resources :analytics, only: :index
  end

  namespace :trade do
    resources :point_of_sales, only: [:show] do
      resources :checkouts, except: [:delete, :show]
    end
    resources :orders, only: :create
  end
end
