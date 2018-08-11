class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie
      .select(:id, :title, :description, :released_at, :genre_id, 'genres.name AS genre_name')
      .joins(:genre)
  end

  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments
    @new_comment = Comment.new(movie: @movie)
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_later
    redirect_back(fallback_location: root_path, notice: "You will soon get an email with movie info!")
  end

  def export
    file_path = "tmp/movies.csv"
    MoviesExportJob.perform_later(current_user, file_path)
    redirect_to root_path, notice: "Movies exported, you will receive an email soon!"
  end
end
