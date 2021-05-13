@articles
Feature: Articles management
  Scenario: Admin can view all articles for given category
    Given I logged in as admin
    When I go to "/cms" page
    And I click Football
    Then I see first 25 articles for given category
