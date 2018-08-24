# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  belongs_to :genre
  has_many :comments

  validates_with TitleBracketsValidator
  delegate :plot, :rating, :poster, to: :remote_movie

  def has_no_comment_by?(user)
    comments.where(user: user).empty?
  end

  def remote_movie
      @delegator ||= RemoteMovie.new(title)
  end

  def self.with_genre_details
    find_by_sql('SELECT movies.id, movies.title, movies.genre_id,
    genres.name AS genre_name, m2.genre_movies_count
    FROM movies
    INNER JOIN genres ON genres.id = movies.genre_id
    INNER JOIN (
      SELECT genre_id, COUNT(genre_id) AS genre_movies_count FROM movies
      GROUP BY genre_id
    ) AS m2 ON m2.genre_id = movies.genre_id')
  end
end
