class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def user_signed_in?
    session[:token].present?
  end
  helper_method :user_signed_in?

  private

  def authenticate_user!
    redirect_to new_user_path unless user_signed_in?
  end
end
