module MoviesApi::V1
  class MoviesController < ActionController::Base
      def index
          movies = Movie.select(fields).all

          respond_to do |format|
              format.json { render json: movies }
          end
      end

      def show
          movie = Movie.select(fields).find(params[:id])

          respond_to do |format|
              format.json { render json: movie }
          end
      end

      private

      def fields
          [:id, :title]
      end
  end
end
