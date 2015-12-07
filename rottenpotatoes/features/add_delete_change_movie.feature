Feature: add or delete or modify a movie
 
  As a movie buff
  I want to add or delete movies
 
Background: movies in database
 
  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |
 
Scenario: add a new movie
  When  I am on the home page
  And   I follow "Add new movie"
  And   I fill in "Title" with "Matchpoint"
  And   I fill in "Director" with "Woody Allen"
  And   I press "Save Changes"
  Then  I should be on the home page
  And   I should see "Matchpoint"
  When  I follow "More about Matchpoint"
  Then  I should see "Woody Allen"

Scenario: delete a movie
  When  I am on the home page
  And   I follow "More about Alien"
  Then  I should be on the details page for "Alien"
  And   I should see "Details about Alien"
  When  I press "Delete"
  Then  I should be on the home page
  And   I should see "Star Wars"
  And   I should see "Blade Runner"
  And   I should see "THX-1138"
  And   I should see "Movie 'Alien' deleted"
  
Scenario: modify a movie
  When  I am on the home page
  And   I follow "More about Alien"
  Then  I should be on the details page for "Alien"
  And   I should see "Details about Alien"
  When  I follow "Edit"
  Then  I should be on the edit page for "Alien"
  And   I should see "Edit Existing Movie"
  When  I fill in "Title" with "Great Gabsy"
  And   I fill in "Director" with "Scorese"
  And   I press "Update Movie Info"
  Then  I should be on the details page for "Great Gabsy"
  And   I should see "Great Gabsy"
  But   I should not see "Alien"