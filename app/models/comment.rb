class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  after_create :expire_ranking

  validates_uniqueness_of :user_id, scope: :movie_id

  def expire_ranking
    Rails.cache.delete(:comments_ranking)
  end
end
