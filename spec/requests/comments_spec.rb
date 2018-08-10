require "rails_helper"

describe "Comments requests", type: :request do
  it "creates a comment" do
    user = create(:user)
    movie = create(:movie)
    comment_body = 'Epic!'

    login_as(user)

    post "/movies/#{movie.id}/comments",
      params: { comment: { body: comment_body } }

    expect(movie.comments.last.body).to eq(comment_body)
  end
end
