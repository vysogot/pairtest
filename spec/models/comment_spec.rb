require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "is unique per user per movie" do
    comment = create(:comment)
    assert_raises(Exception) do
      create(:comment, user: comment.user, movie: comment.movie)
    end
  end

  it "can be destroyed only by author" do
    author = create(:user)
    comment = create(:comment, user: author)
    not_author = create(:user)

    assert !comment.can_be_destroyed_by?(not_author)
    assert comment.can_be_destroyed_by?(author)
  end
end
