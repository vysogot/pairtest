require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "is unique per user per movie" do
    comment = create(:comment)
    assert_raises(Exception) do
      create(:comment, user: comment.user, movie: comment.movie)
    end
  end
end
