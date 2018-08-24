require "rails_helper"

describe "Movies API v2", type: :request do
    describe "listing movies along with genres" do

        let!(:genres) { create_list(:genre, 5, :with_movies) }

        it "gives all the movies with respective genres" do
            get '/movies_api/v2/movies'
            json = JSON.parse(response.body)

            expect(json['movies'].count).to eq(25)

            json['movies'].each do |movie|
              expect(movie['genre_movies_count']).to eq(5)
            end
        end

        it "sends only the expected fields" do
            get '/movies_api/v2/movies'

            sample = JSON.parse(response.body)['movies'].sample

            fields = [
              'id',
              'title',
              'genre_id',
              'genre_name',
              'genre_movies_count'
            ]

            fields.each do |field|
              expect(field).to be_truthy
            end

            without_requested = sample.except(*fields)
            expect(without_requested).to eq({})
        end

    end

end
