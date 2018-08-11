class CommentsRankingController < ApplicationController
  def index
    @top10 = CommentsRanking.top10
  end
end
