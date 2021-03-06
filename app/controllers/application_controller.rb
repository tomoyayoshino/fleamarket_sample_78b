class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_category
  
  private
  def set_category
    @parents = Category.where(ancestry: nil)
  end


  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:nickname, :email, :password, :first_name,
                    :last_name, :first_name, :last_name, :first_name_kana,
                    :last_name_kana, :birthday_year, :birthday_month,
                    :birthday_day, :tel]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
  end
end