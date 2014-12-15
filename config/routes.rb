Rails.application.routes.draw do
  
  ######## home page #######

  root 'static_views#home'

  ######## diagnostics #########

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
  get '/all_create', :to => 'diagnostics#all_create', :as => :all_create 

  ####### analisis #########

  resources :single_files do 
    collection do 
      post 'upload_file'
    end
  end
  
  get '/my_single_files/:id', :to => 'single_files#single_files_x', :as => :single_files_inx


  ######## vital signs ##########
  resources :vital_signs do 
     collection do 
        post 'create_from_user'
     end
  end

  get '/my_vital_signs/:id', :to => 'vital_signs#vital_signs_x', :as => :vital_signs_inx

  ################# intituciones ##############
  
  get 'institutions/create', :as => :institution_create
  post 'institutions/create'
  get 'institutions/update'
  get 'institutions/delete', :as => :institution_delete
  post 'institutions/delete'
  get 'institutions/new', :as => :institutions_new


  ####### sessions #########
  
  resources :sessions

  ######### users resources to posting ########

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
      post 'responce_cite', :as => :responce_cite
      post 'create_notice_cite'
      post '/cites/:id/change', :to => 'users#update_cites', :as => :update_cites
      post 'create_message_cite'
      post 'actualize_invitation_non_mail'
      post 'delete_relation_doctor_patient'

      ############# admin users #############

      post 'admin_user_loggin'
      post 'admin_user_create'
      post 'admin_user_destroy'
      post 'admin_user_cupons'
      post 'search_cupons'


    end
  end
  
  #######user parts#######
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
    get 'responce_cite', :to => 'users#responce_cite', :as => :responce_cite
    get 'cancel_cite', :to => 'users#cancel_cite', :as => :cancel_cite
    get 'users/:id/my_patients', :to => 'users#patients', :as => :patients
    get 'all_cites', :to => 'users#all_cites_viwer', :as => :all_cites_viwer

  ######## admin get for user parts ##########
    get 'users/search_cupons' 
   
  
  ####### comunication parts ########

  resources :messages do 
      collection do 
        post 'create'
        get :events
        get :show
      end
  end

  get '/paginate_messages', :to => 'messages#paginate_messages', :as => :paginate_messages

  
  #######vistas estaticas ##########
  get 'post_id/:id', :to => 'static_views#post',:as => :post_in
  get 'load_view/:id', :to => 'static_views#visualizer',:as => :visualizer
  get 'static_views/home'
  get 'static_views/prices', :as => :prices
  get 'static_views/register', :as => :register
  get 'static_views/about_us', :as => :about_us
  get 'static_views/what_work', :as => :what_work
  get 'static_views/contact', :as => :contact
  get 'static_views/send_contact'
  post 'static_views/send_contact'


  ######## Admin ############

  get 'admin/users', :as => :admin_users
  get 'admin/cupons', :as => :admin_cupons
  get 'admin/payments', :as =>  :admin_payments
  get 'admin/sellers_admin' , as: :sellers_admin
  get 'admin/', :to => 'admin#stats', :as => :admin
  get 'admin/loggin', :as => :admin_loggin
  get '/admins_session_destroy', :to => 'admin#end_session', :as => :admin_end_session
  get 'admin/suspend_user', :as => :suspend_user
  get 'admin/exit_seller', :as => :exit_seller
  get 'admin/create_seller'
  post 'admin/create_seller'
  post 'admin/suspend_user'
  get 'sellers_window', :to => 'admin#sellers_window', :as => :seller
  get 'acces_window', :to  => 'admin#acces_window', :as => :acces_window
  get 'acces_window_validate', :to  => 'admin#acces_window_validate', :as => :acces_window_validate
  post 'acces_window_validate', :to  => 'admin#acces_window_validate'
  get 'pay_ment_by', :to => 'admin#pay_ment_by', :as => :pay_ment_by
  get 'create_user_by_payment_methods', :to => 'admin#create_user_by_payment_methods', as: :create_user_by_payment_methods
  get 'create_user_free', :to => "admin#create_user_by_invite", :as => :create_user_by_invite 
  get 'hospital_manager', :to => "admin#hospital_admin", :as => :hospital_admin

  ############# hospitals #############

  get 'hospitals/view', :as => :hospital
  get 'hospitals/loggin'
  get 'hospitals/users'
  get 'hospitals/stats'
  get 'hospitals/creat_user_hospital'
  get 'hospitals/delete_user_hospital'
  get 'hospitals/create_user_by_hospital'
  get 'hospitals/create_hospital'
  get 'hospitals/session_in'
  post 'hospitals/creat_user_hospital'
  post 'hospitals/delete_user_hospital'
  post 'hospitals/create_user_by_hospital'  
  post 'hospitals/create_hospital'
  post 'hospitals/session_in'

  ############ payments ##########
  post 'payments/send_payment'
  get  'payments/send_payment'
  get  'payments', :to => "payments#payments", :as => :payments
  get  'payments/send_payment_in_cash'
  post 'payments/send_payment_in_cash'

  ########## location #########
  post 'static_views/create_location'
  get 'static_views/create_location'


end
