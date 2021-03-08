class Movie < ActiveRecord::Base
    def self.find_movies_with_the_same_director(director)
        Movie.where({director: director})
    end
end
