Rails.application.routes.draw do
 

  get 'conversations/create'

  get 'conversations/destroy'

  get 'appointments/create'

  get 'appointments/move'

  get 'appointments/destroy'

  resources :diagnostics do 
    collection do
      post 'create_from_user'
      post 'add_note'
    end
  end

  resources :sessions
  
  resources :users do 
    collection do 
      post 'register'
      post 'create_session'
      post 'create_user_by_invite'
      post 'confirmed_token'
      post 'reset_password'
      post 'change_password'
      post 'change_missing_password'
      post 'existent_user_recive_invitation'
    end
  end

  resources :vital_signs do 
     collection do 
        post 'create_from_user'
     end
  end



  get 'users/:id/my_patients', :to => 'users#patients', :as => :patients
  
   
  get 'sign_in', :to => 'users#session_new', :as => :sign_in
  get 'sign_out', :to => 'users#destroy_session', :as => :sign_out
  get '/confirmed_token/:confirmed_token', :to => 'users#confirmed_token', :as => :confirmed_token
  get '/reset_password/:confirmed_token', :to => 'users#reset_password', :as => :reset_password
  get '/change_password', :to => 'users#change_password', :as => :change_password
  get '/missing_password', :to => 'users#missing_password', :as => :missing_password
  get '/terms_and_conditions', :to => 'static_views#terms_and_conditions', :as => :terms_and_conditions
  get '/users/:id/diagnostics', :to => 'users#diagnostics', :as => :diagnostics_users

  #home

  root 'static_views#home'

  #satic_views

  get 'static_views/home'

  get 'static_views/prices'

  get 'static_views/register'

  get 'static_views/about_us'

  
  ####### enviroment for create ###


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
