require 'rails_helper'

describe MoviesController do
   
  describe 'find all movies with the same director' do

    it 'should get movies with the same director when the movie has a director' do
      movie = FactoryBot.create(:movie, :title => 'Jurassic Park', :director => 'Steven Spielberg')
      id = movie.id
      get :find, { id: id }
      allow(Movie).to receive(:find).and_return(movie)
    end

    it "should redirect to the movies page when the movie has no director" do
      movie = FactoryBot.create(:movie, :title => 'Fake Movie', :director => nil)
      id = movie.id
      get :find, { id: id }
      expect(response).to redirect_to(movies_path)
    end
  end
end