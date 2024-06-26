Feature: Allow users to sign up on the portal using an email
  Scenario: Guests see signup button
    Given I go to "/" page
    Then I see the Sign up button in the page header

  Scenario Outline: Error messages displayed on invalid input
    Given I go to "/users/sign_up" page
    When on the sign-up page I entered <Value> for <Field>
    And I click SIGN UP
    Then I see the error message "Please enter valid email"

    Examples:
      | Value     | Field      | Message                                                           |
      |           | email      | Email is required                                                 |
      | not_email | email      | Please enter valid email                                          |
      |           | password   | Password is required                                              |
      | testtest  | password   | Password must contain at least 8 characters (letters and numbers) |

  Scenario: Redirected to home page on signup
    Given I go to "/users/sign_up" page
    When I complete the sign-up form with valid data
    And I click SIGN UP
    Then I redirected to "/' page
