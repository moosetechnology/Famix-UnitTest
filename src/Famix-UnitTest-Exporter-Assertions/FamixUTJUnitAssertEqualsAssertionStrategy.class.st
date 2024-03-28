Class {
	#name : #FamixUTJUnitAssertEqualsAssertionStrategy,
	#superclass : #FamixUTJavaAssertionStrategy,
	#category : #'Famix-UnitTest-Exporter-Assertions'
}

{ #category : #ast }
FamixUTJUnitAssertEqualsAssertionStrategy >> dependencyImportsOn: aFamixUTExporter [

	| model |
	model := aFamixUTExporter model.
	^ { (model newImportDeclaration
		   qualifiedName: (model newQualifiedName name:
					    aFamixUTExporter nameOfJUnitPackage , '.'
					    , aFamixUTExporter nameOfAssertionsClass);
		   isStatic: true;
		   isOnDemand: true) }
]

{ #category : #exporting }
FamixUTJUnitAssertEqualsAssertionStrategy >> export: aFamixUTAssertion on: exporter [

	| model actual expected expectedType |
	model := exporter model.
	actual := model newVariableExpression name: 'actual'.
	expected := exporter valueExporter makeVariableExpression:
		            aFamixUTAssertion expected.
	expectedType := aFamixUTAssertion expected type.
	(expectedType isClass and: [ expectedType isPrimitiveWrapper ])
		ifTrue: [ "assertEquals(Integer, int) is ambiguous, need an explicit cast."
			expected := model newCastExpression
				            type:
					            (expectedType asFASTJavaTypeExpressionOn:
							             exporter valueExporter);
				            expression: expected ].
	^ model newExpressionStatement expression:
		  (model newMethodInvocation
			   name: 'assertEquals';
			   addArgument: expected;
			   addArgument: actual;
			   yourself)
]
