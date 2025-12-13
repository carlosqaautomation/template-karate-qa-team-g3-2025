Feature: Endpoint de producto


  Scenario: Caso 1 product
    * def validateScheme = read('classpath:resources/json/schema/schemes.json')
    * def defrequest =
    """
    {
        "title": "New Product",
        "price": 29.99
    }
    """
    Given url "https://fakestoreapi.com"
    And path "products"
    And match defrequest == validateScheme.request
    And request defrequest
    When method post
    Then status 201
    And match response == validateScheme.product



  Scenario Outline: Caso 2 product
    * def validateScheme = read('classpath:resources/json/schema/schemes.json')
    * def priceFinal = <price> + 0
    Given url "https://fakestoreapi.com"
    And path "products"
    And request read('classpath:resources/json/product/requestProduct.json')
    When method post
    Then status 201
    And match response == validateScheme.product

    Examples:
     |title | price|
    |  televisor    | 1000.1     |
    | laptop        | 2000.5     |
    | cocina        | 500.8     |


  Scenario Outline: Caso 3 product csv <title>
    * def validateScheme = read('classpath:resources/json/schema/schemes.json')
    * def priceFinal = <price> + 0
    Given url "https://fakestoreapi.com"
    And path "products"
    #And request
    #"""
    #{
     # "title": "#(title)",
     # "price": #(priceFinal)
    #}
    #"""
    And request { "title": "#(title)","price": #(priceFinal) }
    #And request read('classpath:resources/json/product/requestProduct.json')
    When method post
    Then status 201
    And match response == validateScheme.product

    Examples:
      |read('classpath:resources/csv/product/product.csv')|