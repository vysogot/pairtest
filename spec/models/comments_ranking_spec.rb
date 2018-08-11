require 'rails_helper'

RSpec.describe CommentsRanking, type: :model do
  it "makes a ranking of top 10 commentators from last 7 days" do
    create_list(:user, 15).each_with_index do |user, i|
      create_list(:comment, i, user: user)
    end

    top_user = User.last
    last_rankable_user = User.find(6)

    create_list(:comment, 2, user: last_rankable_user, created_at: 8.days.ago)

    ranking = CommentsRanking.top10

    assert top_user == ranking.first
    assert last_rankable_user == ranking.last
  end

  it "make sure ranking query is cached" do
    CommentsRanking.top10
    expect(User).not_to receive(:select)
    CommentsRanking.top10
  end

  it "make sure ranking expires on new comment" do
    create(:comment)
    expect(User).to receive(:select).and_call_original
    CommentsRanking.top10
  end
end
