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
