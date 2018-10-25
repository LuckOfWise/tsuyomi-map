class SessionsController < ApplicationController
  skip_before_action :store_location, :authenticate_user!

  def new
    redirect_to '/auth/google_oauth2'
  end

  def create
    auth = request.env['omniauth.auth']
    user = User.find_by(email: auth['info']['email']) || User.find_by(provider: auth['provider'], uid: auth['uid'].to_s) || User.new
    user.save_with_omniauth!(auth)
    redirect_url = after_signin_url
    reset_session
    session[:user_id] = user.id
    redirect_to redirect_url, notice: t('controllers.sign_in', default: 'ログインしました')
  end

  def destroy
    reset_session
    redirect_to root_url, notice: t('controllers.sign_out', default: 'ログアウトしました')
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end
end
