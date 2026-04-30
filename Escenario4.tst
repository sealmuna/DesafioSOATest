---
parasoftVersion: 2025.2.0
productVersion: 10.7.3
schemaVersion: 3
suite:
  $type: TestSuite
  name: Persistencia y Generación de Datos (DB Tool & Data Generator)
  hasEnvironmentConfig: true
  lastModifiedBy: SALMUNAP
  testLogicVariables:
  - $type: TestLogicInteger
    name: id_transaccion
    value:
      $type: TestLogicVariableInteger
  - $type: TestLogicString
    name: fecha
    value:
      $type: TestLogicVariableString
      originalValue: 0
      value: 0
  tests:
  - $type: ToolTest
    name: Data Generator Tool
    testID: 1
    tool:
      $type: DataGeneratorTool
      iconName: DataGeneratorTool
      name: Data Generator Tool
      generators:
      - $type: NumberGenerator
        min:
          values:
          - $type: ScriptedValue
          fixedValue:
            $type: StringTestValue
            min: 100
        max:
          values:
          - $type: ScriptedValue
          fixedValue:
            $type: StringTestValue
            max: 10000
        name: id_transaccion
      - $type: DateTimeGenerator
        inputFormat:
          values:
          - $type: ScriptedValue
          fixedValue:
            $type: StringTestValue
            inputFormat: yyyy-MM-dd hh:mm:ss a
        outputFormat:
          values:
          - $type: ScriptedValue
          fixedValue:
            $type: StringTestValue
            outputFormat: yyyy-MM-dd hh:mm:ss a
        name: fecha
      virtualDSCreator:
        writableColumns:
        - testVariableName: id_transaccion
          mode: 3
          customName: id_transaccion
        - testVariableName: fecha
          mode: 3
          customName: "Test 1: Date/Time 2"
  - $type: ToolTest
    name: DB Tool
    testID: 2
    tool:
      $type: DbTool
      iconName: DBTool
      name: DB Tool Captura Pokemon
      magicToken:
        fixedValue:
          $type: StringTestValue
          value: GO
      outputProviders:
        xmlRequestOutput:
          $type: NamedXMLToolOutputProvider
          name: SQL Query
        xmlResponseOutput:
          $type: NamedXMLToolOutputProvider
          outputTools:
          - $type: XMLAssertionTool
            iconName: XMLAssertor
            name: XML Assertor
            assertions:
            - $type: NumericAssertion
              timestamp: 1777576061752
              name: Numeric Assertion
              Assertion_XPath: /results/resultSet/rows/row/count
              value:
                name: Numeric
                value:
                  fixedValue:
                    $type: StringTestValue
                    value: 1
            message:
              $type: ExpectedXMLMessage
              message: true
          name: Results as XML
        objectOutput:
          $type: ObjectOutputProvider
          outputTools:
          - $type: TrafficViewer
            allowToolbar: false
            iconName: TrafficViewer
            name: Traffic Viewer
            showRequestHeaders: true
            showResponseHeaders: true
          name: Traffic Object
      sqlQuery:
        fixedValue:
          $type: StringTestValue
          useMultipleLines: true
          value: |-
            INSERT INTO captura_pokemon (pokemon_name, id_transaccion,fecha) VALUES ("charmander",${id_transaccion},"${fecha}");
            SELECT count(*) FROM captura_pokemon WHERE id_transaccion =${id_transaccion};
      failOnSQLException: true
      account:
        local:
          $type: DbConfigSettings
          uri: jdbc:mysql://localhost:3306/desafio
          username: root
          driver: com.mysql.cj.jdbc.Driver
