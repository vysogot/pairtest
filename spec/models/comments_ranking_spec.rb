require 'rails_helper'

RSpec.describe CommentsRanking, type: :model do
  it "makes a ranking of top 10 commentators" do
    create_list(:user, 15).each_with_index do |user, i|
      create_list(:comment, i, user: user)
    end

    top_user = User.last
    last_rankable_user = User.find(6)

    ranking = CommentsRanking.top10

    assert top_user == ranking.first
    assert last_rankable_user == ranking.last
  end
end
