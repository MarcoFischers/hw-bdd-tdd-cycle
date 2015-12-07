#require 'spec_helper'
require_relative 'rails_helper'

describe Movie do

  describe 'find similar movies' do
    context 'when they exist' do
      before :each do
        # create 2 movies with same director
        Movie.create(:title => 'Star Wars 3', :director => 'Newman', :rating => 'PG')
        Movie.create(:title => 'Trek Star'  , :director => 'Newman', :rating => 'G')
      end

      it 'and 2 movies found' do
        movie = Movie.where(:title => 'Trek Star').first
        @movies = Movie.find_similar(movie)
        expect(@movies.size).to eq(2)
      end
    end

    context 'when no similar movies exist' do
      before :each do
        # create 2 movies with different directors
        Movie.create(:title => 'Star Wars 3', :director => 'Newman', :rating => 'PG')
        Movie.create(:title => 'Trek Star'  , :director => 'Oldmen', :rating => 'G')
      end
      
      it 'and no movies found' do
        movie = Movie.where(:title => 'Trek Star').first
        @movies = Movie.find_similar(movie)
        expect(@movies.size).to eq(1)
      end
    end
  end

end