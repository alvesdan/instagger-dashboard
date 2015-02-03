class ReportVariation < Struct.new(:user_data)

  def variations
    {
      posts: variation_for(:posts),
      likes: variation_for(:likes),
      comments: variation_for(:comments)
    }
  end

  private

  def variation_for(key)
    key_symbol = "total_#{key}".to_sym
    first_week = user_data.first.fetch(key_symbol, 0).to_f
    last_week = user_data.last.fetch(key_symbol, 0).to_f

    return (last_week * 100) if first_week.zero?
    return (first_week * -100) if last_week.zero?

    percentage = ((last_week - first_week) / first_week) * 100
    percentage = (first_week * 100) if percentage == Float::INFINITY
    percentage.round
  end
end
