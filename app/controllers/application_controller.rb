class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  rescue_from Instagram::BadRequest, with: :sign_out_user

  def user_signed_in?
    token.present?
  end
  helper_method :user_signed_in?

  private

  def authenticate_user!
    redirect_to new_user_path unless user_signed_in?
  end

  def token
    @token ||= session[:token]
  end

  def client
    @client ||= Instagram.client(access_token: token)
  end

  def current_user
    @current_user ||= Rails.cache.fetch([token, 'me'], expires_in: 1.hour) do
      client.user
    end
  end
  helper_method :current_user

  def sign_out_user
    redirect_to '/sign-out'
  end

  def purge_cache!
    Rails.cache.delete([token, 'me'])
    Rails.cache.delete([token, 'user_media'])
  end

end
