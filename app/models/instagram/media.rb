module Instagram
  class Media < OpenStruct
    def created_at
      Time.at(created_time.to_i)
    end

    def likes_count
      likes['count']
    end

    def comments_count
      comments['count']
    end

    def week_number
      created_at.strftime('%W')
    end
  end
end
