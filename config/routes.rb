Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :manage do
    resources :products
    resources :point_of_sales
  end
end
