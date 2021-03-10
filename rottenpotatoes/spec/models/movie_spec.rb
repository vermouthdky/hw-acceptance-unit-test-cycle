require 'rails_helper'

describe Movie do
  describe 'with_director class method' do
    # 'build' creates but doesn't save object;  'create' creates AND saves it to the DB
      movie1 = FactoryBot.create(:movie, :title => 'Star Wars', :director => 'George Lucas')
      movie2 = FactoryBot.create(:movie, :title => 'Blade Runner', :director => 'Ridley Scott')
      movie3 = FactoryBot.create(:movie, :title => 'TTHX-1138', :director => 'George Lucas')

      it "should return correct matches for movies by the same director" do
        expect(Movie.with_director('George Lucas').pluck(:title).uniq).to eq ['Star Wars', 'TTHX-1138']
        expect(Movie.with_director(movie3.director).pluck(:title).uniq).to eq ['Star Wars', 'TTHX-1138']
        expect(Movie.with_director('Ridley Scott').pluck(:title).uniq).to eq ['Blade Runner']
      end
    
      it "should not return matches of movies by different directors" do
        expect(Movie.with_director('George Lucas').pluck(:title).uniq).not_to eq ['Blade Runner']
        expect(Movie.with_director('George Lucas').pluck(:title).uniq).not_to eq ['Star Wars', 'Blade Runner']
        expect(Movie.with_director('Ridley Scott').pluck(:title).uniq).not_to eq ['Star Wars', 'TTHX-1138']
      end
      
  end

end