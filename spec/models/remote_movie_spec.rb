require 'rails_helper'

describe RemoteMovie do

    it 'returns a movie, rating and plot or right kind' do
        movie = create(:movie, :title => 'Godfather')

        expect(movie.plot).to be_kind_of String
        expect(movie.rating).to be_kind_of Numeric
        expect(movie.poster).to be_kind_of String
    end

    it 'returns correct movie poster url' do
        movie = create(:movie, :title => 'Godfather')

        expect(movie.poster).to eq('https://pairguru-api.herokuapp.com/godfather.jpg')
    end

end
