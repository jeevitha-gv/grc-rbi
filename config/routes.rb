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
      get 'audit_observation'
      post 'update_individual_score'
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
    post 'import_files', on: :collection
    get 'export_files', on: :collection
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

  # You can have the root of your site routed with "root"
  root 'home#index'
end
