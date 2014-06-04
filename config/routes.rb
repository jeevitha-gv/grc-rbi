Rails.application.routes.draw do


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post 'admin/privileges/modal_previlege'
  post 'admin/compliance_libraries/compliance_control_objectives'
  post 'admin/compliance_libraries/compliance_controls'
  post 'admin/compliance_libraries/compliance_domains'
  devise_for :users

  resources :home

  resources :checklist_recommendations do
    collection do
      get 'auditee_response'
      get 'audit_observation'
    end
  end

  resources :nc_questions

  resources :audits do
    get 'departments_list', on: :collection
    get 'teams_list', on: :collection
  end


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

  # You can have the root of your site routed with "root"
  root 'home#index'

  resources :companies do
    member do
      get 'settings'
    end
    collection do
      get 'welcome', to: 'companies#welcome', :as => :welcome
    end
   end

   # delete '/activities/clear_audit' => 'activities#clear_audit', :as => :clear_audit
   resources :activities, :except => [:show]

    resources :compliance_libraries
    resources :audit_compliances


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
