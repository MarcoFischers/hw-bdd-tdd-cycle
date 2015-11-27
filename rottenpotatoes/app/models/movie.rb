class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def Movie.find_similar(movie)
    ordering = {:title => :asc}
    Movie.where(director: movie.director).order(ordering)
  end

end
