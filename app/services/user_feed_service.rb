class UserFeedService < Struct.new(:client)

  def user_media
    @user_media ||= fetch_media.map do |media|
      Instagram::Media.new(media.to_hash)
    end
  end

  private

  def fetch_media
    current_page = client.user_recent_media
    results = current_page
    begin
      next_page = current_page.pagination.next_max_id
      break unless next_page
      current_page = client.user_recent_media(max_id: next_page)
      results += current_page
    end while inside_range?(results)
    results
  end

  def inside_range?(list)
    list.map { |m|
      Time.at(m.created_time.to_i)
        .to_date
        .beginning_of_week.to_s
    }.uniq.size < 4
  end
end
