class UserReportService < Struct.new(:user_media)

  def report
    result = {
      variations: ReportVariation.new(usable_data).variations,
      aggregate: usable_data
    } if usable_data.size > 1

    result || {}
  end

  def usable_data
    @usable_data ||= aggregate_numbers.last(2)
  end

  def aggregate_numbers
    @aggregate_numbers ||= grouped_user_media.map do |week, media|
      {
        week_start: format_date(media.first.created_at.beginning_of_week),
        week_end: format_date(media.last.created_at.end_of_week),
        total_posts: media.size,
        total_likes: media.reduce(0) { |sum, m| sum += m.likes_count },
        total_comments: media.reduce(0) { |sum, m| sum += m.comments_count }
      }
    end
  end

  def format_date(date)
    date.strftime('%d/%m')
  end

  private

  def ordered_user_media
    @ordered_user_media ||= user_media.sort_by(&:beginning_of_week)
  end

  def grouped_user_media
    @grouped_user_media ||= ordered_user_media.group_by(&:beginning_of_week)
  end
end
