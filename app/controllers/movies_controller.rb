# frozen_string_literal: true

require './app/models/movie'

class MoviesController < AplicationController
  def index
    [
      200,
      { 'Content-Type' => 'application/json' },
      [Movie.all.to_json]
    ]
  end

  def show
    movie = Movie.find(id: params[:id])

    return not_found unless movie

    [
      200,
      { 'Content-Type' => 'application/json' },
      [movie.to_json]
    ]
  end

  def create
    movie = Movie.create(params[:record_params])

    if movie.errors.any?
      [
        400,
        { 'Content-Type' => 'application/json' },
        [movie.errors.to_json]
      ]
    else
      [201, {}, []]
    end
  end

  def update
    return not_found unless Movie.find(id: params[:id])

    movie = Movie.update(params[:record_params].merge(id: params[:id]))

    if movie.errors.any?
      [
        400,
        { 'Content-Type' => 'application/json' },
        [movie.errors.to_json]
      ]
    else
      [204, {}, []]
    end
  end

  def destroy
    movie = Movie.find(id: params[:id])

    return not_found unless movie

    Movie.destroy(id: params[:id])

    [204, {}, []]
  end
end
