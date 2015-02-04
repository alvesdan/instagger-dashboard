class UserReportServiceDecorator < SimpleDelegator
  def week_one
    OpenStruct.new(
      report.fetch(:aggregate, []).first
    )
  end

  def week_two
    OpenStruct.new(
      report.fetch(:aggregate, []).last
    )
  end

  def week_title(key)
    week = self.send(:"week_#{key}")
    return nil unless week
    [week.week_start, week.week_end].join(' - ')
  end

  def variations
    OpenStruct.new(
      report.fetch(:variations, {})
    )
  end

  def chart_data
    @chart_data ||= user_media.reverse.group_by(&:date).map { |date, media|
      {
        date: date,
        total_posts: media.size,
        total_likes: media.reduce(0) { |sum, m| sum += m.likes_count },
        total_comments: media.reduce(0) { |sum, m| sum += m.comments_count }
      }
    }.select do |date|
      usable_data.map { |week|
        week.fetch(:week_start)
      }.include?(format_date(date.fetch(:date).beginning_of_week))
    end
  end

  def direction_for(key)
    number = variations.send(key)
    return 'flat' if number.zero?
    number > 0 ? 'up' : 'down'
  end

  def icon_for(key)
    direction = direction_for(key)

    case direction
    when 'flat'
      'minus'
    when 'up'
      'chevron-up'
    else
      'chevron-down'
    end
  end
end
