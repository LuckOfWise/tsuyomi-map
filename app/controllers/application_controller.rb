class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception


  before_action :store_location, :authenticate_user!

  helper_method :current_user
  helper_method :user_signed_in?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_organization
    @current_organization ||= current_user.organization
  end

  def user_signed_in?
    true if current_user
  end

  def authenticate_user!
    if !current_user
      redirect_to signin_url, alert: 'ログインしてください'
    end
  end

  def store_location
    return unless request.get?
    session[:previous_url] = request.fullpath if !request.xhr?
  end

  def after_signin_url
    session[:previous_url] || mypage_url
  end
end
