require "rails_helper"

describe "Comments ranking", type: :request do

  it "shows the ranking page" do
    visit '/comments_ranking'
    expect(page).to have_css('h1', count: 1, text: 'Top Commentators')
  end

  it "shows top 10 commentators" do
    create_list(:user, 15).each_with_index do |user, i|
      create_list(:comment, i, user: user)
    end

    top_user = User.last
    last_rankable_user = User.find(6)

    visit '/comments_ranking'
    expect(page).to have_css('.ranking tr', count: 10)
    expect(page).to have_css('.ranking tr#1', count: 1,
                             text: top_user.name + ': ' +
                             Comment.where(user: top_user).count.to_s
                            )

    expect(page).to have_css('.ranking tr#10', count: 1,
                             text: last_rankable_user.name + ': ' +
                             Comment.where(user: last_rankable_user).count.to_s
                            )
  end

end
