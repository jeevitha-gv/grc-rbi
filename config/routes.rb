Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post 'admin/privileges/modal_previlege'
  post 'admin/compliance_libraries/compliance_control_objectives'
  post 'admin/compliance_libraries/compliance_controls'
  post 'admin/compliance_libraries/compliance_domains'
  post 'admin/compliance_libraries/import_files'
  post 'admin/compliance_libraries/export_files'
  post 'admin/privileges/role_privileges'
  post 'admin/transactions/cancel_recurring'

  devise_for :users

  resources :home

   resources :dashboard do
     collection do
      get 'calender'
      patch 'update'
     end
   end

   resources :risk_dashboard do
     collection do
      patch 'update'
     end
   end

  resources :risks do
    collection do
      get 'department_teams_users'
      post 'risk_imports'
      get 'risk_export'
      get 'download_risk_document'
      delete 'remove_attachment'
      get ':id/risk_per_dashboard', to: 'risks#risk_per_dashboard', as: 'risk_per_dashboard'
    end
    resources :mgmt_reviews
    resources :mitigations
    collection do
      get 'download_document'
    end
  end

  resources :audits do
    collection do
      get 'department_teams_users'
      post 'audit_with_status'
      post 'audit_all'
      post 'audit_imports'
      get 'audit_export'
      post 'asc_calculation'
      get 'maximum_actual_score'
      get ':id/audit_dashboard', to: 'audits#audit_dashboard', as: 'audit_dashboard'
      get ':id/artifacts_download', to: 'audits#artifacts_download', as: 'artifacts_download'
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
    resource :answers, only: [:index, :create, :new]
 end

 resources :other_assets do
  collection do
    post 'other_asset_imports'
    get 'other_asset_export'
    delete 'remove_attachment'
    get 'download_other_asset_document'
  end
end

 resources :computers do
  collection do
    post 'computer_imports'
    get 'computer_export'
  end
 end

 resources :documents do
  collection do
    post 'document_imports'
    get 'document_export'
  end
end

  resources :mobile_assets do
    collection do
      post 'mobile_asset_imports'
      get 'mobile_asset_export'
    end
    
  end

 resources :vendors do
  collection do
    post 'vendor_imports'
    get 'vendor_export'
  end
  end

  resources :softwares do
    collection do
      post 'software_imports'
      get 'software_export'
    end
  end


   resources :contracts do
   end

   resources :services do
    collection do
      post 'service_imports'
      get 'service_export'
    end
   end
   
  scope '/assets' do
    resources :information_assets
  end
  
  resources :assets do  
    resources :assessments
    resources :asset_actions
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
  resources :audit_compliances do
    post 'submit', on: :collection
  end

  resources :plans

  resources :transactions, only: [:new, :create]

  resources :update_payments

  get 'welcome', to: 'companies#welcome', :as => :welcome

  # You can have the root of your site routed with "root"
  root 'home#index'
end
