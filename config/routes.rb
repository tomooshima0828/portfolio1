Rails.application.routes.draw do

  root 'static_pages#top'
  get "/menus_overview", to: 'static_pages#menus_overview'
  get "/staff", to: 'static_pages#staff'
  get "/inquiry", to: 'static_pages#inquiry'

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
      # GET	/users/:id/admin_top
      get "admin_top"
      resources :menus
    end
    resources :events, except: :show do
      collection do # collectionはevent idなし
        # GET /users/:user_id/events/edit_account_info
        get "edit_account_info"
        # PATCH /users/:user_id/events/update_account_info
        patch "update_account_info"
      end
    end

  end

  
  
end
