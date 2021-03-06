require "rails_helper"

describe "Comments ranking", type: :request do

  it "shows the ranking link and page" do
    visit '/'
    click_link 'Comments ranking'
    expect(page).to have_css('h1', count: 1, text: 'Top 10 commentators')
  end

  it "shows top 10 commentators from last 7 days" do
    create_list(:user, 15).each_with_index do |user, i|
      create_list(:comment, i, user: user)
    end

    top_user = User.last
    last_rankable_user = User.find(6)

    create_list(:comment, 2, user: last_rankable_user, created_at: 8.days.ago)

    visit '/comments_ranking'

    expect(page).to have_css('.table tbody tr', count: 10)
    expect(page).to have_css('.table tbody tr#1 .name', count: 1, text: top_user.name)
    expect(page).to have_css('.table tbody tr#1 .score', count: 1,
                             text: Comment.where(
                               user: top_user,
                               created_at: 7.days.ago..Time.now
                             ).count.to_s
                            )

    expect(page).to have_css('.table tbody tr#10 .name', count: 1, text: last_rankable_user.name)
    expect(page).to have_css('.table tbody tr#10 .score', count: 1,
                             text: Comment.where(
                               user: last_rankable_user,
                               created_at: 7.days.ago..Time.now
                             ).count.to_s
                            )
  end

end
