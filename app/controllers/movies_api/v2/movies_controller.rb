module MoviesApi::V2
  class MoviesController < ::MoviesApi::V1::MoviesController
      def index
          movies = Movie.select(fields).all
          genres = Genre.select(:id,
                                :name,
                                'count(genre_id) as number_of_movies'
                               ).joins(:movies).group(:genre_id).all

          respond_to do |format|
              format.json { render json: { movies: movies, genres: genres } }
          end
      end
  end
end
