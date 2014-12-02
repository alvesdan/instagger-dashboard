class DashboardController < ApplicationController
  respond_to :html, :json
  def show
    respond_with user_report_service.report
  end

  private

  def token
    @token ||= session[:token]
  end

  def client
    @client ||= Instagram.client(access_token: token)
  end

  def user_media
    @user_media ||= Rails.cache.fetch(token, expires_in: 1.hour) do
      user_feed_service.user_media
    end
  end

  def user_feed_service
    @user_feed_service ||= UserFeedService.new(client)
  end

  def user_report_service
    @user_report_service ||= UserReportService.new(user_media)
  end
end
