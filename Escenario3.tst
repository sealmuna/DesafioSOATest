---
parasoftVersion: 2025.2.0
productVersion: 10.7.3
schemaVersion: 3
suite:
  $type: TestSuite
  name: Lógica Personalizada (Extension Tool)
  hasEnvironmentConfig: true
  environmentConfig:
    environments:
    - variables:
      - name: urlBase
        value: https://pokeapi.co/api/v2
      name: Variables
      active: true
  lastModifiedBy: SALMUNAP
  testLogicVariables:
  - $type: TestLogicString
    name: peso
    value:
      $type: TestLogicVariableString
      originalValue: 0
      value: 0
  - $type: TestLogicString
    name: kilogramos
    value:
      $type: TestLogicVariableString
      originalValue: 0
      value: 0
  tests:
  - $type: RESTClientToolTest
    name: REST Client
    testID: 1
    tool:
      $type: RESTClient
      iconName: RESTClient
      name: REST Snorlax
      outputTools:
      - $type: GenericDataBank
        iconName: XMLDataBank
        name: JSON Data Bank Peso
        wrappedTool:
          $type: XMLtoDataSource
          iconName: XMLDataBank
          name: XML Data Bank
          selectedXPaths:
          - elementOption: 1
            contentOption: 1
            XMLDataBank_ExtractXPath: "/root/weight[1]/text()"
            mode: 1
          canonicalizeOutput: true
          xmlMessage: true
          virtualDSCreator:
            writableColumns:
            - testVariableName: peso
              mode: 3
              customName: "Test 1: weight"
        conversionStrategy:
          dataFormatName: JSON
          conversionStrategyId: JSON
          conversionStrategyClassName: com.parasoft.xml.convert.json.JsonConversionStrategy
      - $type: MethodTool
        iconName: Method
        name: Extension Tool Conversion peso a Kg
        method:
          hasCode: true
          code:
            $type: ScriptCode
            input:
              useText: true
              textInput:
                $type: ScriptingTextInput
                text: "import com.parasoft.api.*\n\nvoid convertirPeso(Object input,\
                  \ ScriptingContext context) {\n\t\t//Application.showMessage(\"\
                  message\");\n\t\t\n        def peso = context.getValue(\"Generated\
                  \ Data Source\",\"peso\")\n\t\t\n        if (peso == null) {\n \
                  \           context.report(\"Error: No se recibió el valor de 'peso'\"\
                  )\n            return\n        }\n\n        try {\n            int\
                  \ pesoValor = Integer.parseInt(peso.toString())\n            int\
                  \ kilogramos = pesoValor / 10\n\n            // Guardar el resultado\
                  \ en el contexto\n            context.put(\"kilogramos\", kilogramos.toString())\n\
                  \n            // Reportar mensaje informativo\n            Application.showMessage(\"\
                  Conversión realizada: ${pesoValor} -> ${kilogramos} kg\")\n\n  \
                  \      } catch (Exception e) {\n            context.report(\"Error\
                  \ al convertir el peso: \" + e.getMessage())\n        }\n    }\n"
          hasMethodId: true
          methodId:
            $type: ScriptMethodIdentifier
            functionName: convertirPeso
            arguments:
            - java.lang.Object
            - com.parasoft.api.ScriptingContext
      formJson:
        value:
          $type: ElementValue
          writeType: true
          type:
            $type: ElementType
            localName: root
            bodyType:
              $type: ComplexType
              attributes:
              - ns: ""
                name: type
                fixed: object
                contentType:
                  $type: StringType
                required: true
              name: rootType
              compositor: true
              compositorObj:
                $type: AllCompositor
          replacedColumn: ""
          values:
          - $type: ComplexValue
            replacedColumn: ""
            attributes:
            - replacedColumn: ""
              value:
                $type: StringValue
                replacedColumn: ""
                value: object
              useValue: true
            compositorValue: true
            compositorValueObj:
              replacedColumn: ""
              values:
                $type: CompositorValueSetCollectionSet
                set:
                - $type: CompositorValueSet
        elementTypeName: root
      jsonBuilder:
        hasValue: true
        value:
          $type: JSONObjectValue
          nameIsNull: true
      formInput:
        value:
          $type: ElementValue
          writeType: true
          type:
            $type: ElementType
            localName: ""
            bodyType:
              $type: ComplexType
              name: anonymous
              compositor: true
              compositorObj:
                $type: SequenceCompositor
          replacedColumn: ""
          values:
          - $type: ComplexValue
            replacedColumn: ""
            compositorValue: true
            compositorValueObj:
              replacedColumn: ""
              values:
                $type: CompositorValueSetCollectionSet
                set:
                - $type: CompositorValueSet
      constrainToSchema: false
      jmsMessageOutputProvider:
        $type: JMSMessageOutputProvider
        jmsOutputProviderRequest:
          $type: JMSOutputProvider
          name: Request Object
          menuName: Object
        jmsOutputProviderResponse:
          $type: JMSOutputProvider
          name: Response Message Object
          menuName: Message Object
      validResponseRange:
        validResponseRange:
          values:
          - $type: ScriptedValue
          fixedValue:
            $type: StringTestValue
            validResponseRange: 200
      router:
        values:
        - $type: ScriptedValue
        fixedValue:
          $type: StringTestValue
          HTTPClient_Endpoint: "${urlBase}/pokemon/snorlax"
      transportProperties:
        manager:
          protocol: 1
          properties:
          - $type: HTTPClientHTTPProperties
            followRedirects:
              bool: true
            common:
              method:
                values:
                - $type: ScriptedValue
                fixedValue:
                  $type: HTTPMethodTestValue
                  method: GET
            protocol: 1
            keepAlive1_1:
              bool: true
        messageExchangePattern:
          inverted: true
      outputProviders:
        requestHeader:
          $type: HTTPNamedToolOutputProvider
          menuName: Transport Header
          name: Request Transport Header
        responseHeader:
          $type: HTTPNamedToolOutputProvider
          menuName: Transport Header
          name: Response Transport Header
        xmlRequestOutput:
          $type: NamedXMLToolOutputProvider
          menuName: Traffic
          name: Request Traffic
        trafficOutput:
          m_name: Traffic Stream
        objectOutput:
          $type: ObjectOutputProvider
          outputTools:
          - $type: TrafficViewer
            iconName: TrafficViewer
            name: Traffic Viewer
            showRequestHeaders: true
            showResponseHeaders: true
          name: Traffic Object
      literal:
        use: 1
        text:
          MessagingClient_LiteralMessage: ""
          type: application/json
        dataSource:
          columnName: kilogramos
      mode: Literal
      literalQuery:
        isPropertiesRef: true
      literalPath:
        pathElements:
        - values:
          - $type: ScriptedValue
          fixedValue:
            $type: StringTestValue
            value: pokemon
        - values:
          - $type: ScriptedValue
          fixedValue:
            $type: StringTestValue
            value: snorlax
      resourceMethod:
        httpMethod: GET
      baseUrl:
        values:
        - $type: ScriptedValue
        - $type: WadlTestValue
        fixedValue:
          $type: StringTestValue
        selectedIndex: 1
