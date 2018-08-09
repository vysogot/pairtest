class RemoteMoviesController < ActionController::Base
    def show
        @remote_movie = RemoteMovie.new(params[:title])

        respond_to do |format|
            format.json { render json: @remote_movie }
        end
    end
end
