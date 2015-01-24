class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    session[:token] = request_token
    redirect_to root_path
  end

  def destroy
    session.delete(:token)
    Rails.cache.delete([token, 'me'])
    Rails.cache.delete([token, 'user_media'])
    Rails.cache.delete([token, 'user_last_media'])
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def request_token
    auth_hash['credentials']['token']
  end
end
