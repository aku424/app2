class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_user
    if current_user == nil
      redirect_to new_user_session_path
    end
  end

  protected
  def after_sign_in_path_for(resource)
    user_path(resource) # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end

  def configure_permitted_parameters
  	#devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  	devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

end
