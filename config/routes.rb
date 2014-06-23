Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post 'admin/privileges/modal_previlege'
  post 'admin/compliance_libraries/compliance_control_objectives'
  post 'admin/compliance_libraries/compliance_controls'
  post 'admin/compliance_libraries/compliance_domains'
  post 'admin/compliance_libraries/import_files'
  post 'admin/compliance_libraries/export_files'
  post 'admin/privileges/role_privileges'

  devise_for :users

  resources :home

   resources :dashboard do
     collection do
      get 'calender'
     end
   end


  resources :audits do
<<<<<<< HEAD
    collection do
      get 'department_teams_users'
      post 'audit_with_status'
      post 'audit_all'
      post 'import_files'
      get 'export_files'
      post 'asc_calculation'
      get 'maximum_actual_score'
      get 'audit_dashboard'
      get 'artifacts_download'
    end
    resources :checklist_recommendations do
      collection do
        get 'auditee_response'
        post 'audit_observation_create'
        post 'auditee_response_create'
        get 'audit_observation'
        post 'update_individual_score'
        get 'list_artifacts_and_comments'
        get 'download_artifacts'
        delete 'remove_attachment'
      end
    end
    resources :audit_compliances, only: [:index, :create, :update] do
      collection do
        get 'edit'
        get 'compliance_checklist'
        get 'response'
        get 'response_checklist'
      end
    end
    resources :nc_questions do
      collection do
        get 'library_questions'
        post 'import_files'
        get 'export_files'
      end
  end
=======
    get 'department_teams_users', on: :collection
    post 'audit_with_status', on: :collection
    post 'audit_all', on: :collection
    post 'audit_imports', on: :collection
    get 'audit_export', on: :collection
    post 'asc_calculation', on: :collection
    get 'maximum_actual_score' , on: :collection
    get 'audit_dashboard' , on: :collection
    get 'artifacts_download' , on: :collection
>>>>>>> a2405e42227a5a8817d76472a0c4730fee841a63
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
    get '/' => 'dashboard#index'
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

  resources :artifact_answers do
    collection do
      get 'list_attachments'
      get 'list_comment'
      post 'create_attachment'
      patch 'update_comment'
      delete 'remove_attachment'
    end
  end

  resources :compliance_libraries

  get 'welcome', to: 'companies#welcome', :as => :welcome

  # You can have the root of your site routed with "root"
  root 'home#index'
end
