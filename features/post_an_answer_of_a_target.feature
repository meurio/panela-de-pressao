Feature: post an answer of a target
  In order to keep people up to date with the campaign's repercussion
  As a campaigner
  I want to post an answer of a target
  
  @omniauth_test @ssi
  Scenario: when I'm logged in as an admin
    Given I'm logged in as admin
    And there is a campaign called "A Vida das Ariranhas"
    And I'm in this campaign page
    And I click "the campaign answers button"
    And I fill "answer_text" with "Viva la vida!"
    When I press "Criar Resposta"
    Then I should be in "the answers page of the campaign"
    And I should see "Viva la vida!"

  @omniauth_test @ssi
  Scenario: when I'm not the campaign's creator
    Given I'm logged in
    And there is a campaign called "A Vida das Ariranhas"
    And I'm in this campaign page
    When I click "Respostas"
    Then I should not see "the answer form"
