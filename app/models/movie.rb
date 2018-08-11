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
end
