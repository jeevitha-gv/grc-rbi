class Devise::ConfirmationsController < DeviseController
  # GET /resource/confirmation/new
  def new
    self.resource = resource_class.new
  end

  # POST /resource/confirmation
  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?
    # sign_in resource, :bypass => true
    if successfully_sent?(resource)
     flash[:forgot_notice]   = "You will receive an Email with Activation Link "
      respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?
    sign_in resource, :bypass => true
    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      respond_with_navigational(resource){ redirect_to password_user_path }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end

  protected

    # The path used after resending confirmation instructions.
    def after_resending_confirmation_instructions_path_for(resource_name)
      new_session_path(resource_name) if is_navigational_format?
    end

    # The path used after confirmation.
    def after_confirmation_path_for(resource_name, resource)
      if signed_in?
        signed_in_root_path(resource)
      else
        new_session_path(resource_name)
      end
    end
end
