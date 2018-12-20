Rails.application.routes.draw do
  devise_for :accounts, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  namespace :manage do
    resources :products
    resources :point_of_sales
    resources :accounts
  end

  namespace :trade do
    resources :point_of_sales do
      get :complete_change
      post :complete_change
      post :checkout, on: :member, param: :point_of_sale_id
    end
    resources :orders, only: :create
  end
end
