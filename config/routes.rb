# frozen_string_literal: true

Rails.application.routes.draw do
  resources :pages, except: 'index'
  resources :contacts, only: %i[new create]
  get '/contacts' => redirect('/contacts/new')
  get '/event' => redirect('/pages/2')
  get '/donors' => redirect('/pages/3')
  post 'products/:id', to: 'products#add'
  delete 'cart/:id', to: 'cart#remove', as: 'remove'
  get 'cart', to: 'cart#index'
  match 'cart/checkout' => 'cart#checkout', as: 'checkout', via: %i[get post]
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
