class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    session[:token] = request_token
    redirect_to root_path
  end

  def destroy
    Rails.cache.delete([token, 'me'])
    Rails.cache.delete([token, 'user_media'])
    Rails.cache.delete([token, 'user_last_media'])
    session.delete(:token)
    redirect_to root_path
  end

  private

  def auth_hash
    request.env.fetch('omniauth.auth')
  end

  def request_token
    auth_hash.fetch('credentials').fetch('token')
  end
end
