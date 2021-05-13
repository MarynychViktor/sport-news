TODO: refactor
@ia
Feature: An admin user creates the navigation menu categories
  Background:
    Given I go to "/cms/information_architecture" page

  Scenario: Open new category popover
    When I click + Add category
    Then I see the popover with Add new category title
    And I see Cancel button
    And I see Add button

  Scenario: Close popover without creating category
    Given I open new category modal
    When I click Cancel
    Then I see popover with title Add new category is closed
    And the category is not added

  Scenario: Create new category
    Given I open new category modal
    When I type the category name test2
    When I click Add
    Then I see popover with title Add new category is closed
    And the category is added
    And I see this category with test2 at the top of the list