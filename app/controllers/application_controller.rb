class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?



  protected

	  def configure_permitted_parameters
	    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :dob, 
        :ovga_team, :gender_boy, :gender_girl, 
        :category_jun,:category_juv,:category_ban,:category_pee,:category_ato, :user_type_id])
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :dob, 
        :ovga_team, :gender_boy, :gender_girl, 
        :category_jun,:category_juv,:category_ban,:category_pee,:category_ato, :user_type_id])
		end


end
