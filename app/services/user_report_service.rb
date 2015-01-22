class UserReportService < Struct.new(:user_media)

  def report
    result = {
      variations: build_result(usable_data),
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

  private

  def ordered_user_media
    @ordered_user_media ||= user_media.sort_by(&:beginning_of_week)
  end

  def grouped_user_media
    @grouped_user_media ||= ordered_user_media.group_by(&:beginning_of_week)
  end

  def build_result(slice)
    Hash[
      [:posts, :likes, :comments].map do |key|
        key_symbol = "total_#{key}".to_sym
        first_slice_value = slice.first.fetch(key_symbol, 0).to_f
        last_slice_value = slice.last.fetch(key_symbol, 0).to_f
        percentage = ((last_slice_value - first_slice_value) / first_slice_value) * 100
        percentage = (first_slice_value * 100) if percentage == Float::INFINITY
        [key, percentage.round]
      end
    ]
  end

  def format_date(date)
    date.strftime('%d/%m')
  end
end
