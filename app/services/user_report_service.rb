class UserReportService < Struct.new(:user_media)

  def report
    ([]).tap do |result|
      aggregate_numbers.each_cons(2) do |slice|
        result << build_result(slice) if slice.size > 1
      end
    end
  end

  def aggregate_numbers
    @aggregate_numbers ||= grouped_user_media.map do |day, media|
      {
        total_posts: media.size,
        total_likes: media.reduce(0) { |sum, m| sum += m.likes_count },
        total_comments: media.reduce(0) { |sum, m| sum += m.comments_count }
      }
    end
  end

  private

  def grouped_user_media
    @grouped_user_media ||= user_media.group_by do |media|
      media.created_at.strftime('%U')
    end
  end

  def build_result(slice)
    Hash[
      [:posts, :likes, :comments].map do |key|
        key_symbol = "total_#{key}".to_sym
        first_slice_value = slice.first[key_symbol].to_f
        last_slice_value = slice.last[key_symbol].to_f
        percentage = ((first_slice_value - last_slice_value) / last_slice_value.to_i) * 100 rescue (first_slice_value * 100)
        [key, percentage]
      end
    ]
  end
end
