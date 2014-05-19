class AuditsController < ApplicationController
  before_action :authenticate_user!
  before_action :current_company_disabled

  def index
    
  end


  private

    def current_company_disabled
      if Company.find(current_user.company_id).is_disabled == true
        sign_out :user
        redirect_to new_user_session_path
      end
    end


end
