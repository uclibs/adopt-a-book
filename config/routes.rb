# frozen_string_literal: true

Rails.application.routes.draw do
  post 'products/:id', to: 'products#add'
  delete 'cart/:id', to: 'cart#remove', as: 'remove'
  get 'cart', to: 'cart#index'
  post 'cart/checkout', to: 'cart#checkout', as: 'checkout'
  post 'cart/payment', to: 'cart#payment', as: 'payment'
  delete 'cart', to: 'cart#destroy'
  devise_for :admins, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :products, except: [:index] do
    collection do
      get 'status/:status', to: 'products#index', as: 'status'
    end
  end
  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
