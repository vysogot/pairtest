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
    delete "/comments/#{comment.id}"

    assert @movie.comments.empty?
  end

  it "displays comments belonging to a movie" do
    create_list(:comment, 5, movie: @movie)
    create_list(:comment, 5)

    visit "/movies/#{@movie.id}"

    expect(page).to have_selector(".comment", count: 5)
  end

  it "displays comment form for a logged in user without a comment" do
    sign_in(@user)
    visit "/movies/#{@movie.id}"

    expect(page).to have_selector("form#new_comment", count: 1)
  end

  it "creates a comment on submiting the form" do
    sign_in(@user)
    visit "/movies/#{@movie.id}"
    comment_body = 'This is exactly what I think about this movie'

    within(:css, "form#new_comment") do
      fill_in('Your comment', with: comment_body)
      click_button('Send')
    end

    expect(@movie.comments.last.body).to eq(comment_body)
    expect(@movie.comments.last.user).to eq(@user)
  end

  it "deletes a comment by clicking on a link" do
    comment = create(:comment, user: @user, movie: @movie)

    login_as(@user)
    visit "/movies/#{@movie.id}"
    click_link 'Delete'

    assert @movie.comments.empty?
  end

  it "shows delete link only to the owner of a comment" do
    comment = create(:comment, user: @user, movie: @movie)

    login_as(create(:user))
    visit "/movies/#{@movie.id}"

    expect(page).not_to have_link('Delete')
  end

  it "shows comment form only to a logged in user" do
    comment = create(:comment, user: @user, movie: @movie)

    visit "/movies/#{@movie.id}"

    expect(page).not_to have_selector("form#new_comment", count: 1)
    expect(page).to have_link('Log in to comment')
  end

  it "shows comment form only when user didn't comment the movie" do
    comment = create(:comment, user: @user, movie: @movie)

    sign_in(@user)
    visit "/movies/#{@movie.id}"

    expect(page).not_to have_selector("form#new_comment", count: 1)
    expect(page).to have_text('You can have one comment per movie. Delete your comment to add the new one.')
  end

end
