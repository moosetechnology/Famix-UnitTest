Class {
	#name : #FamixUTAssertJRecursiveComparisonAssertionStrategy,
	#superclass : #FamixUTJavaAssertionStrategy,
	#category : #'Famix-UnitTest-Exporter-Assertions'
}

{ #category : #ast }
FamixUTAssertJRecursiveComparisonAssertionStrategy >> dependencyImportsOn: aFamixUTExporter [

	| model |
	model := aFamixUTExporter model.
	^ {
		  (model newImportDeclaration
			   qualifiedName:
				   (model newQualifiedName name: 'org.assertj.core.api.Assertions');
			   isStatic: true;
			   isOnDemand: true).
		  (model newImportDeclaration qualifiedName:
			   (model newQualifiedName name:
				    'org.hibernate.collection.PersistentSet')) }
]

{ #category : #exporting }
FamixUTAssertJRecursiveComparisonAssertionStrategy >> export: aFamixUTAssertion on: exporter [

	| model actual expected |
	model := exporter model.
	actual := model newVariableExpression name: 'actual'.
	expected := exporter valueExporter makeVariableExpression:
		            aFamixUTAssertion expected.
	self flag: #TODO. "simplify assertion if expected is not an object or a collection."
	^ model newExpressionStatement expression:
		  (model newMethodInvocation
			   receiver: (model newMethodInvocation
					    receiver: (model newMethodInvocation
							     receiver: (model newMethodInvocation
									      receiver: (model newMethodInvocation
											       name: 'assertThat';
											       addArgument: actual;
											       yourself);
									      name: 'usingRecursiveComparison');
							     name: 'ignoringCollectionOrder');
					    name: 'ignoringFieldsOfTypes';
					    addArgument: (model newClassProperty
							     type: (model newIdentifier name: 'PersistentSet');
							     fieldName: 'class');
					    yourself);
			   name: 'isEqualTo';
			   addArgument: expected;
			   yourself)
]
