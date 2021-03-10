require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

describe MoviesController do
   
  describe 'find all movies with the same director' do
    it 'should get movies with the same director when the movie has a director' do
      @movie = FactoryBot.create(:movie, :title => 'Star Wars', :director => 'George Lucas')
      
      expect(Movie).to receive(:with_director).and_return(@movie)
      get :show_the_same_director, { id: @movie.id }
      expect(response).to render_template(:show_the_same_director)
    end

    it "should redirect to the movies page when the movie has no director" do
      @movie = FactoryBot.create(:movie, :title => 'Alien', :director => "")
      get :show_the_same_director, { id: @movie.id }
      expect(response).to redirect_to(movies_path)
    end
  end
end