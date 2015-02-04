module Instagram
  class Media < OpenStruct
    def created_at
      Time.at(created_time.to_i)
    end

    def date
      created_at.to_date
    end

    def likes_count
      likes['count']
    end

    def comments_count
      comments['count']
    end

    def beginning_of_week
      created_at.to_date.beginning_of_week.to_s
    end
  end
end
