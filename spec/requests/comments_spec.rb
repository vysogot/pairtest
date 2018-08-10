require "rails_helper"

describe "Movie comments requests", type: :request do

  before do
    @user = create(:user)
    @movie = create(:movie)
  end

  it "creates a comment" do
    comment_body = 'Epic!'

    login_as(@user)
    post "/movies/#{@movie.id}/comments",
      params: { comment: { body: comment_body } }

    expect(@movie.comments.last.body).to eq(comment_body)
    expect(@movie.comments.last.user).to eq(@user)
  end

  it "deletes a comment" do
    comment = create(:comment, user: @user, movie: @movie)

    login_as(@user)
    delete "/movies/#{@movie.id}/comments/#{comment.id}"

    assert @movie.comments.empty?
  end

  it "displays comments belonging to a movie" do
    create_list(:comment, 5, movie: @movie)
    create_list(:comment, 5)

    visit "/movies/#{@movie.id}"

    expect(page).to have_selector(".comment", count: 5)
  end

end
