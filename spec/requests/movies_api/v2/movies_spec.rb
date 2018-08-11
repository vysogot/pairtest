require "rails_helper"

describe "Movies API v2", type: :request do
    describe "listing movies along with genres" do

        let!(:genres) { create_list(:genre, 5, :with_movies) }

        it "gives all the movies and genres" do
            get '/movies_api/v2/movies'
            json = JSON.parse(response.body)

            expect(json['movies'].count).to eq(25)
            expect(json['genres'].count).to eq(5)
            json['genres'].each do |genre|
                expect(genre['number_of_movies']).to eq(5)
            end
        end

        it "sends only id and title in movies" do
            get '/movies_api/v2/movies'

            sample = JSON.parse(response.body)['movies'].sample

            expect(sample['id']).to be_truthy
            expect(sample['title']).to be_truthy

            without_requested = sample.except('id', 'title')
            expect(without_requested).to eq({})
        end

        it "sends only id, name, number_of_movies in genres" do
            get '/movies_api/v2/movies'
            sample = JSON.parse(response.body)['genres'].sample

            expect(sample['id']).to be_truthy
            expect(sample['name']).to be_truthy
            expect(sample['number_of_movies']).to be_truthy

            without_requested = sample.except('id', 'name', 'number_of_movies')
            expect(without_requested).to eq({})
        end

    end

end
