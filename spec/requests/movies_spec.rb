require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end

    it "exports movies for logged in user" do
      sign_in(create(:user))
      expect(MoviesExportJob).to receive(:perform_later)
      visit '/movies/export'
    end

    it "dont export movies for not logged in user" do
      expect(MoviesExportJob).not_to receive(:perform_later)
      visit '/movies/export'
    end
  end

end
