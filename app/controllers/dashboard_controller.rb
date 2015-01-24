class DashboardController < ApplicationController
  respond_to :html
  def show
  end

  private

  def user_media
    @user_media ||= Rails.cache.fetch([token, 'user_media'], expires_in: 1.hour) do
      user_feed_service.user_media
    end
  end

  def user_feed_service
    @user_feed_service ||= UserFeedService.new(client)
  end

  def user_report_service
    @user_report_service ||= UserReportService.new(user_media)
  end

  def user_report_service_decorator
    @user_report_service_decorator ||= UserReportServiceDecorator.new(user_report_service)
  end
  helper_method :user_report_service_decorator
end
