class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    redirect_to '/auth/instagram'
  end

  def create
    session[:token] = token
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def token
    auth_hash['credentials']['token']
  end
end