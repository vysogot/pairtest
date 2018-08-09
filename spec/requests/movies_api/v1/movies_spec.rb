require "rails_helper"

describe "Movies API v1", type: :request do
    describe "listing movies" do

        let!(:movies) { create_list(:movie, 5) }

        it "gives all the movies" do
            get '/movies_api/v1/movies'
            json = JSON.parse(response.body)

            expect(json.count).to eq(5)
        end

        it "sends only id and title" do
            get '/movies_api/v1/movies'
            sample = JSON.parse(response.body).sample

            without_requested = sample.except('id', 'title')
            expect(without_requested).to eq({})
        end

        it "sends id and title" do
            get '/movies_api/v1/movies'
            sample = JSON.parse(response.body).sample

            expect(sample['id']).to be_truthy
            expect(sample['title']).to be_truthy
        end

    end

end
