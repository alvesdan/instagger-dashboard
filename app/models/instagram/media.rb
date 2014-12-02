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
  end
end
