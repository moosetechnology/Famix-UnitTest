Class {
	#name : 'FamixUTAssertJJavaAssertionStrategy',
	#superclass : 'FamixUTAbstractJavaAssertionStrategy',
	#instVars : [
		'ignoringFieldsOfTypes',
		'usingRecursiveComparison',
		'ignoringCollectionOrder'
	],
	#category : 'Famix-UnitTest-Exporter-Strategies',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Strategies'
}

{ #category : 'ast' }
FamixUTAssertJJavaAssertionStrategy >> dependencyImportsOn: aFamixUTExporter [

	| model |
	model := aFamixUTExporter model.
	^ { (model newImportDeclaration
		   qualifiedName: (model newQualifiedName name:
					    'org.assertj.core.api.Assertions.assertThat');
		   isStatic: true) }
]

{ #category : 'exporting' }
FamixUTAssertJJavaAssertionStrategy >> export: aFamixUTAssertion on: exporter [
	"Make an assertion using AssertJ: assertThat(actual).{options}.isEqualTo(expected)"

	| model expected assertion |
	model := exporter model.
	expected := aFamixUTAssertion expected.
	assertion := model newMethodInvocation
		             addArgument:
			             (model newVariableExpression name: 'actual');
		             name: 'assertThat'.
	(self usingRecursiveComparison and: [
		 expected isOfObject or: [
			 expected isOfCollection or: [ expected isOfDictionary ] ] ])
		ifTrue: [
			assertion := model newMethodInvocation
				             receiver: assertion;
				             name: 'usingRecursiveComparison'.
			(self ignoringCollectionOrder and: [ expected containsCollection ])
				ifTrue: [
					assertion := model newMethodInvocation
						             receiver: assertion;
						             name: 'ignoringCollectionOrder' ].
			(self ignoringFieldsOfTypes isNotEmpty and: [
				 expected containsObject ]) ifTrue: [
				assertion := model newMethodInvocation
					             receiver: assertion;
					             name: 'ignoringFieldsOfTypes';
					             arguments:
						             (ignoringFieldsOfTypes collect: [ :typeName |
								              model newClassProperty
									              type: (model newIdentifier name: typeName);
									              fieldName: 'class' ]) ] ].
	assertion := model newMethodInvocation
		             receiver: assertion;
		             addArgument:
			             (exporter valueExporter makeVariableExpression:
					              expected);
		             name: 'isEqualTo'.
	^ model newExpressionStatement expression: assertion
]

{ #category : 'accessing' }
FamixUTAssertJJavaAssertionStrategy >> ignoringCollectionOrder [

	^ ignoringCollectionOrder ifNil: [ ignoringCollectionOrder := false ]
]

{ #category : 'accessing' }
FamixUTAssertJJavaAssertionStrategy >> ignoringCollectionOrder: aBoolean [

	ignoringCollectionOrder := aBoolean
]

{ #category : 'accessing' }
FamixUTAssertJJavaAssertionStrategy >> ignoringFieldsOfTypes [

	^ ignoringFieldsOfTypes ifNil: [ ignoringFieldsOfTypes := {  } ]
]

{ #category : 'accessing' }
FamixUTAssertJJavaAssertionStrategy >> ignoringFieldsOfTypes: aCollection [

	ignoringFieldsOfTypes := aCollection
]

{ #category : 'accessing' }
FamixUTAssertJJavaAssertionStrategy >> usingRecursiveComparison [

	^ usingRecursiveComparison ifNil: [
		  usingRecursiveComparison := false ]
]

{ #category : 'accessing' }
FamixUTAssertJJavaAssertionStrategy >> usingRecursiveComparison: aBoolean [

	usingRecursiveComparison := aBoolean
]
