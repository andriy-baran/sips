require 'json'

Rails.application.routes.draw do
  mount RoutesGraph::Engine, at: '/r'
  devise_for :accounts, :controllers => { registrations: 'registrations' }
  root to: "home#index"
  namespace :manage do
    resources :products
    resources :point_of_sales do
      resources :checkins, except: [:destroy, :show]
    end
    resources :accounts
    resources :analytics, only: :index
    resources :dashboard, only: :index
  end

  namespace :trade do
    resources :point_of_sales, only: [:show] do
      resources :checkouts, except: [:destroy, :show]
    end
    resources :orders, only: :create
  end
end
