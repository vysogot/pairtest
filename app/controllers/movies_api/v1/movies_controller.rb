module MoviesApi::V1
  class MoviesController < ActionController::Base
      def index
          movies = Movie.select(:id, :title).all

          respond_to do |format|
              format.json { render json: movies }
          end
      end
  end
end
