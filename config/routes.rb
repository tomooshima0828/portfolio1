Rails.application.routes.draw do
  
  root 'static_pages#top'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end

  devise_for :customers, :controllers => {
    :registrations => 'customers/registrations',
    :sessions => 'customers/sessions'   
  } 
  
  devise_scope :customer do
    get "sign_in", :to => "customers/sessions#new"
    get "sign_out", :to => "customers/sessions#destroy" 
  end

  resources :users

  resources :customers
  
end
