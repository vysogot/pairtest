module MoviesApi::V2
  class MoviesController < ::MoviesApi::V1::MoviesController
      def index
        movies = Movie.with_genre_details
          respond_to do |format|
              format.json { render json: { movies: movies } }
          end
      end
  end
end
