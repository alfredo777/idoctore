Rails.application.routes.draw do
 
  resources :diagnostics do 
    collection do
      post 'create_from_user'
      post 'add_note'
      post 'destroy'
    end
  end
  get 'cie10', :to => 'diagnostics#cie10', :as =>  :cie10
  get 'plain_show/:id', :to => 'diagnostics#plain_show', :as => :plain_show
  get 'qrcode_view/:id', :to => 'diagnostics#qrcode_view', :as => :qrcode_view
  get 'printing_diagnostic/:id', :to => 'diagnostics#printing_diagnostic', :as => :diagnostics_print
  get 'printing_threatment/:id', :to => 'diagnostics#printing_threatment', :as => :printing_threatment
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
      post '/:id/actualize', :to => 'users#actualize',:as => :user_update
      post 'send_request_cite'
      post 'responce_cite'
      post 'create_notice_cite'
      post '/cites/:id/change', :to => 'users#update_cites', :as => :update_cites
      post 'create_message_cite'
      post 'actualize_invitation_non_mail'
      post 'delete_relation_doctor_patient'
    end
  end

  resources :messages do 
      collection do 
        post 'create'
        get :events
        get :show
      end
  end
  get '/paginate_messages', :to => 'messages#paginate_messages', :as => :paginate_messages
  resources :vital_signs do 
     collection do 
        post 'create_from_user'
     end
  end


  get 'users/:id/my_patients', :to => 'users#patients', :as => :patients
  get 'post_id/:id', :to => 'static_views#post',:as => :post_in
  get 'load_view/:id', :to => 'static_views#visualizer',:as => :visualizer



  get 'sign_in', :to => 'users#session_new', :as => :sign_in
  get 'sign_out', :to => 'users#destroy_session', :as => :sign_out
  get '/confirmed_token/:confirmed_token', :to => 'users#confirmed_token', :as => :confirmed_token
  get '/reset_password/:confirmed_token', :to => 'users#reset_password', :as => :reset_password
  get '/change_password', :to => 'users#change_password', :as => :change_password
  get '/missing_password', :to => 'users#missing_password', :as => :missing_password
  get '/terms_and_conditions', :to => 'static_views#terms_and_conditions', :as => :terms_and_conditions
  get '/users/:id/diagnostics', :to => 'users#diagnostics', :as => :diagnostics_users
  get '/users/:id/actualize', :to => 'users#actualize',:as => :user_update
  get '/options_change_cite', :to => 'users#options_change_cite', :as => :change_cite
  get '/local_confirm_relation', :to => 'users#actualize_invitation_non_mail', :as => :local_confirm_relation
  get '/local_delete_relation', :to => 'users#delete_relation_doctor_patient', :as => :local_delete_relation
  get '/clear_cache_user', :to => 'users#clear_cache_user', :as => :clear_cache_user





  #home

  root 'static_views#home'

  #satic_views

  get 'static_views/home'

  get 'static_views/prices'

  get 'static_views/register'

  get 'static_views/about_us'

end
