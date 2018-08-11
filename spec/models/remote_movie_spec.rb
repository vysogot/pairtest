require 'rails_helper'

describe RemoteMovie do

    before do
      stub_request(:get, "https://pairguru-api.herokuapp.com/api/v1/movies/Godfather").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip, deflate',
       	  'Host'=>'pairguru-api.herokuapp.com',
       	  'User-Agent'=>'rest-client/2.0.2 (darwin17.7.0 x86_64) ruby/2.5.1p57'
           }).
         to_return(status: 200,
                   body: '{"data":{"id":"6","type":"movie","attributes":{"title":"Godfather","plot":"The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.","rating":9.2,"poster":"/godfather.jpg"}}}',
                   headers: {})
    end

    it 'returns a movie, rating and plot or right kind' do
        movie = create(:movie, :title => 'Godfather')

        expect(movie.plot).to eq('The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.')
        expect(movie.rating).to eq(9.2)
        expect(movie.poster).to eq('https://pairguru-api.herokuapp.com/godfather.jpg')
    end

end
