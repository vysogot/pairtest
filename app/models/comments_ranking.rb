class CommentsRanking
  class << self
    def top10
      Rails.cache.fetch :comments_ranking do
        User.select(:id, :name, Arel.sql('count(*) AS comments_count'))
          .where(comments: { created_at: 7.days.ago..Time.now })
          .joins(:comments)
          .group(:user_id)
          .order(Arel.sql('count(*) DESC'))
          .limit(10)
      end
    end
  end
end
