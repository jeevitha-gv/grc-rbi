Rails.application.routes.draw do
  get 'fraud_dashboard/index'

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

  resources :charges

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

   resources :control_dashboard do
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

 resources :vendors do
  collection do
    post 'vendor_imports'
    get 'vendor_export'
  end
  end


   resources :contracts do
   end

   resources :frauds do
    resources :investigations
    resources :fraud_reviews
   end

  resources :asset_dashboard do
    collection do
      get 'calendar'
      get 'computers'
    end
  end

  resources :bcm_dashboard do
  end

  scope '/bcm' do

    resources :bc_analyses do

      resources :bc_plans

      resources :bc_implementations

      resources :bc_acceptances

      resources :bc_maintenances
      
    end

  end


  scope '/inventory' do
    
    resources :information_assets do
      collection do
        post 'infoasset_imports'
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
        get  'document_export'
      end
    end

    resources :other_assets do
      collection do
        post 'other_asset_imports'
        get 'other_asset_export'
        delete 'remove_attachment'
        get 'download_other_asset_document'
      end
    end
  
    resources :services do
      collection do
        post 'service_imports'
        get 'service_export'
      end
    end

    resources :mobile_assets do
      collection do
        post 'mobileasset_imports'
        get 'mobile_asset_export'
      end
    end
 
    resources :source_codes do
      collection do
        post 'sourcecode_imports'
        get 'sourcecode_export'
      end
    end

    resources :softwares do
      collection do
        post 'software_imports'
        get 'software_export'
      end
    end

  end
  
  
  resources :assets do  
    resources :assessments

    resources :asset_reviews

    resources :asset_actions do
      collection do
        get 'owner_action'
        post 'owner_action_create'
      end
    end

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



  # Resources for policy

  resources :policies do
    resources :policy_reviews
    member do
      get 'show_individual'
      get 'show_version'
    end
    collection do
      get 'export'
      get 'share_policy'
      post 'send_emails_to_share'
    end
    resources :policy_approvals
    resources :publish_policies
  end

  resources :company_controls  do
    collection do
      get 'export'
    end
  end

  resources :policy_dashboards do
    collection do
      get 'calender'
    end
  end

  resources :fraud_dashboard do
    collection do
      
    end
  end



  get 'welcome', to: 'companies#welcome', :as => :welcome

  
# INCIDENT MANAGEMENT

  resources :incidents do 
    collection do 
      post 'import'
      get 'export'
      get 'incident_dashboard'
      get 'incident_calender'
      #patch 'update'
      # get 'download_evaluate_document'
      delete 'remove_attachment'
      get 'download_incident_document'
    end
  resources :closes  
  resources :evaluates  
  resources :resolutions
    collection do 
      delete 'remove_attachment'
      get 'download_resolution_document'
      end

  end

  # CONTROL MANAGEMENT

  resources :controls do
    resources :control_approvals
    resources :control_reviews
    resources :control_audits
  end

  
root 'home#index'

end



