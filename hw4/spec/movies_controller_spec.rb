require_relative 'spec_helper'
require_relative 'rails_helper'
 
RSpec.describe MoviesController, :type => :controller do
  describe 'searching similar movies happy path' do
    before :each do
      @fake_movie = double('movie1', :director => 'Newman')
      @fake_results = [double('movie1'), double('movie2')]
    end
    it 'should call the model method that performs similar movies search' do
      expect(Movie).to receive(:find).with('2') { @fake_movie }
      expect(Movie).to receive(:find_similar).with(@fake_movie) { @fake_results }
      post :similar, {:id => '2'}
    end
    it 'should select the Search Results template for rendering' do
      allow(Movie).to receive(:find).with('2') { @fake_movie }
      allow(Movie).to receive(:find_similar).with(@fake_movie) { @fake_results }
      post :similar, {:id => '2'}
      expect(response).to render_template('similar')
    end
    it 'should make the similar movies search results available to that template' do
      allow(Movie).to receive(:find).with('2') { @fake_movie }
      allow(Movie).to receive(:find_similar).with(@fake_movie) { @fake_results }
      post :similar, {:id => '2'}
      expect(assigns(:movies)).to eq(@fake_results)
    end
  end

  describe 'searching similar movies sad path' do
    before :each do
      @fake_movie = double('movie1', :director => nil, :title => 'Just a movie')
    end
    it 'should call the model method that performs movie retrieve' do
      expect(Movie).to receive(:find).with('2') { @fake_movie }
      post :similar, {:id => '2'}
    end
    it 'should select the home page template for rendering' do
      allow(Movie).to receive(:find).with('2') { @fake_movie }
      post :similar, {:id => '2'}
      expect(response).to render_template(nil)
    end
  end
end
