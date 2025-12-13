@smoke
Feature: Casos de login

  @login-exitoso
  Scenario: Caso 1 - login exitoso
    Given url urlBase
    And path "/auth"
    And request read('classpath:resources/json/auth/bodyLogin.json')
    When method post
    Then status 200
    * def authToken = response.token
    * print "Mi variable es:"+ authToken


  @login-fallido
  Scenario: Caso 2 - Login con contrasena incorrecta
    Given url urlBase
    And path "/auth"
    And request
    """
    {
        "username" : "admin",
        "password" : "1qasas"
    }
    """
    When method post
    Then status 200
    And match response.reason == "Bad credentials"