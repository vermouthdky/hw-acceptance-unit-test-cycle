Feature: search for movies by director

  As a movie buff
  So that I can find movies with my favorite director
  I want to include and search on director information in movies I enter

Background: movies in database

  Given the following movies exist:
  | title                   | rating | director     | release_date |
  | Star Wars               | PG     | George Lucas | 1977-05-25   |
  | Blade Runner            | PG     | Ridley Scott | 1982-06-25   |
  | Alien                   | R      |              | 1979-05-25   |
  | THX-1138                | R      | George Lucas | 1971-03-11   |
  | When Harry Met Sally    | R      |              | 1971-03-11   |
  | The Help                | PG-13  |              | 1971-03-11   |
  | Chocolat                | PG-13  |              | 1971-03-11   |
  | Amelie                  | R      |              | 1971-03-11   |
  | 2001: A Space Odyssey   | G      |              | 1971-03-11   |
  | The Incredibles         | PG     |              | 1971-03-11   |
  | Raiders of the Lost Ark | PG     |              | 1971-03-11   |
  | Chicken Run             | G      |              | 1971-03-11   |

Scenario: add director to existing movie
  When I go to the edit page for "Alien"
  And  I fill in "Director" with "Ridley Scott"
  And  I press "Update Movie Info"
  Then the director of "Alien" should be "Ridley Scott"

Scenario: find movie with same director
  Given I am on the details page for "Star Wars"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the Similar Movies page for "Star Wars"
  And   I should see "THX-1138"
  But   I should not see "Blade Runner"

Scenario: can't find similar movies if we don't know director (sad path)
  Given I am on the details page for "Alien"
  Then  I should not see "Ridley Scott"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the home page
  And   I should see "'Alien' has no director info"
  
Scenario: create new movie
  When I am on the homepage
  And I follow "Add new movie"
  Then  I should be on the creat new movie page
  And I fill in "Title" with "Frozen"
  And I fill in "Director" with "Chris Buck"
  And I select "PG" from "Rating"
  And I select "2017" from "movie_release_date_1i"
  And I select "November" from "movie_release_date_2i"
  And I select "27" from "movie_release_date_3i"
  And I press "Save Changes"
  Then I should be on the RottenPotatoes home page
  And I should see "Frozen"
  
Scenario: delete movie
  When I am on the homepage
  And I follow "More about Alien"
  Then I should be on the details page for "Alien"
  And I follow "Delete"
  Then I should be on the RottenPotatoes home page
  And I should see "Movie 'Alien' deleted."
