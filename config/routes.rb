Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post 'admin/privileges/modal_previlege'
  post 'admin/compliance_libraries/compliance_control_objectives'
  post 'admin/compliance_libraries/compliance_controls'
  post 'admin/compliance_libraries/compliance_domains'
  post 'admin/compliance_libraries/import_files'
  post 'admin/compliance_libraries/export_files'

  devise_for :users

  resources :home

  resources :checklist_recommendations do
    collection do
      get 'auditee_response'
      post 'audit_observation_create'
      post 'auditee_response_create'
      get 'audit_observation'
      post 'update_individual_score'
    end
  end

 resources :dashboard do
   collection do
    get 'calender'
   end
 end

  resources :nc_questions do
    get 'library_questions', on: :collection
    post 'import_files', on: :collection
    get 'export_files', on: :collection
  end

  resources :audits do
    get 'departments_list', on: :collection
    get 'teams_list', on: :collection
    post 'audit_with_status', on: :collection
    post 'audit_all', on: :collection
    post 'import_files', on: :collection
    get 'export_files', on: :collection
  end

  resource :answers

  resource :user do
    collection do
      patch 'update_password'
    end
    get "password"
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # subdomain root path
  constraints(Subdomain) do
    get '/' => 'audits#index'
  end

  resources :companies do
    member do
      get 'settings'
    end
    collection do
      get 'welcome', to: 'companies#welcome', :as => :welcome
    end
<<<<<<< HEAD
   end

   # delete '/activities/clear_audit' => 'activities#clear_audit', :as => :clear_audit
   resources :activities, :except => [:show]

    resources :compliance_libraries
    resources :audit_compliances do 
      get 'compliance_checklist', on: :collection
    end


   get 'welcome', to: 'companies#welcome', :as => :welcome

   # resources :privileges

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
=======
  end
>>>>>>> 9d20476608ca4a47773aadb3352f1ac03c8d75ad

  # delete '/activities/clear_audit' => 'activities#clear_audit', :as => :clear_audit
  resources :activities, :except => [:show]

  resources :compliance_libraries
  resources :audit_compliances

  get 'welcome', to: 'companies#welcome', :as => :welcome

  # You can have the root of your site routed with "root"
  root 'home#index'
end
