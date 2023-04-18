Class {
	#name : #FamixUTJUnitExporter,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Famix-UnitTest-Exporter'
}

{ #category : #exporting }
FamixUTJUnitExporter >> exportMethod: aFamixUTMethod [

	^ self model newMethodEntity
		  name: (aFamixUTMethod name ifNil: [ 
					   'test' , aFamixUTMethod testedMethod name capitalized ]);
		  addModifier: (model newAnnotation expression:
					   (model newVariableExpression name: 'Test'));
		  addModifier: (model newModifier token: 'public');
		  type: model newVoidTypeExpression;
		  statementBlock: model newStatementBlock
]

{ #category : #'as yet unclassified' }
FamixUTJUnitExporter >> model [

	^ model ifNil: [ model := FASTJavaModel new ]
]
