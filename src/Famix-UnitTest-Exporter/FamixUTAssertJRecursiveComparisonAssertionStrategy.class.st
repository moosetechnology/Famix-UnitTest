Class {
	#name : #FamixUTAssertJRecursiveComparisonAssertionStrategy,
	#superclass : #FamixUTJavaAssertionStrategy,
	#category : #'Famix-UnitTest-Exporter-Strategies'
}

{ #category : #ast }
FamixUTAssertJRecursiveComparisonAssertionStrategy >> dependencyImportsOn: aFamixUTExporter [

	| model |
	model := aFamixUTExporter model.
	^ {
		  (model newImportDeclaration
			   qualifiedName: (model newQualifiedName name:
						    'org.assertj.core.api.Assertions.assertThat');
			   isStatic: true).
		  (model newImportDeclaration qualifiedName:
			   (model newQualifiedName name:
				    'org.hibernate.collection.PersistentSet')) }
]

{ #category : #exporting }
FamixUTAssertJRecursiveComparisonAssertionStrategy >> export: aFamixUTAssertion on: exporter [
	"Make an assertion using AssertJ: assertThat(actual).isEqualTo(expected)"

	| model expected assertion |
	model := exporter model.
	expected := aFamixUTAssertion expected.
	assertion := model newMethodInvocation
		             addArgument:
			             (model newVariableExpression name: 'actual');
		             name: 'assertThat'.
	"if expected is a complex type, use recursive comparison, and ignore collection order and PersistentSet fields"
	(expected isOfObject or: [
		 expected isOfCollection or: [ expected isOfDictionary ] ]) ifTrue: [
		assertion := model newMethodInvocation
			             receiver: (model newMethodInvocation
					              receiver: (model newMethodInvocation
							               receiver: assertion;
							               name: 'usingRecursiveComparison');
					              name: 'ignoringCollectionOrder');
			             addArgument: (model newClassProperty
					              type: (model newIdentifier name: 'PersistentSet');
					              fieldName: 'class');
			             name: 'ignoringFieldsOfTypes' ].
	assertion := model newMethodInvocation
		             receiver: assertion;
		             addArgument:
			             (exporter valueExporter makeVariableExpression:
					              expected);
		             name: 'isEqualTo'.
	^ model newExpressionStatement expression: assertion
]
