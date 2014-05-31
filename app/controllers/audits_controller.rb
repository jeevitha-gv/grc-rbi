class AuditsController < ApplicationController
  before_action :authenticate_user!
  before_filter :check_company_disabled

  def index

  end

  def new
    @audit = Audit.new
  end

  def create
    @audit = Audit.new(audit_params)

    if @audit.save
      redirect_to new_audit_path
    else
      render 'new'
    end
  end



  private
    def audit_params
      params.require(:audit).permit(:title, :objective, :deliverables, :context, :issues, :scope, :methodology, :client_id)
    end

    def current_company_disabled
      if Company.find(current_user.company_id).is_disabled == true
        sign_out :user
        redirect_to new_user_session_path
      end
    end


end
