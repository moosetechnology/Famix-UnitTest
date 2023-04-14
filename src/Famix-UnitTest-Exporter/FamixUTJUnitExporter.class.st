Class {
	#name : #FamixUTJUnitExporter,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Famix-UnitTest-Exporter'
}

{ #category : #'as yet unclassified' }
FamixUTJUnitExporter >> exportMethod: aFamixUTMethod [

	^ self model newMethodEntity
		  name: aFamixUTMethod name;
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
