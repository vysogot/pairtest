class GenresController < ApplicationController
  def index
    @genres = Genre
      .select(:id, :name, :created_at, Arel.sql('count(*) AS number_of_movies'))
      .joins(:movies)
      .group(:genre_id)
  end

  def movies
    @genre = Genre.find(params[:id])
    @movies = Movie
      .where(genre_id: @genre.id)
      .select(:id, :title, :description, :released_at, :genre_id, 'genres.name AS genre_name')
      .joins(:genre)
  end
end
