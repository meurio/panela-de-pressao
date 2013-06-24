Feature: create an update for a campaign
  In order to keep people up to date with the campaign
  As an admin
  I want to create an update for a campaign

  @omniauth_test @javascript @koala
  Scenario: when I'm an admin user and submit the form right
    Given I'm logged in as admin
    And there is an accepted campaign
    And I'm in this campaign page
    When I click in the updates button
    Then I should see the new update button
    Given I click in the new update button
    And I fill the new update form right
    When I submit the new update form
    Then I should be in the updates page of the campaign
    And I should see the new update in a facebox
    And I should see the new update in the Meu Rio Facebook page

  Scenario: when I'm an admin user and submit the form wrong
  Scenario: when I'm not an admin user