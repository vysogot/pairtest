require 'rails_helper'

describe RemoteMovie do

    it 'returns a movie plot' do
        movie = create(:movie, :title => 'Godfather')

        expect(movie.plot).to be_kind_of String
    end

    it 'returns a movie rating' do
        movie = create(:movie, :title => 'Godfather')

        expect(movie.rating).to be_kind_of Numeric
    end

    it 'returns a movie poster' do
        movie = create(:movie, :title => 'Godfather')

        expect(movie.poster).to be_kind_of String
    end

    it 'returns correct movie poster url' do
        movie = create(:movie, :title => 'Godfather')

        expect(movie.poster).to eq('https://pairguru-api.herokuapp.com/godfather.jpg')
    end

end
