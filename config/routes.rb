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

  resources :users do
    member do # memberは:idあり
      # GET	/users/:id/edit_event_response
      get "edit_event_response"
      patch "update_event_response"
      delete "destroy_event_response"
      
      patch "update_request_status"
    end
    resources :events, except: :show
  end
  
end
