require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "checks if user already commented on a movie" do
    user = create(:user)
    movie = create(:movie)

    create(:comment, user: user, movie: movie)

    assert movie.has_no_comment_by?(create(:user))
    expect(movie.has_no_comment_by?(user)).to eq(false)
  end
end
