Class {
	#name : #FamixUTSUnitAssertionStrategy,
	#superclass : #FamixUTAbstractStrategy,
	#category : #'Famix-UnitTest-Exporter-Exporters'
}

{ #category : #exporting }
FamixUTSUnitAssertionStrategy >> export: aFamixUTAssertion on: exporter [

	^ aFamixUTAssertion expected resultInSpan tags
		  at: 'error'
		  ifPresent: [ :error |
			  self export: aFamixUTAssertion shouldRaise: error on: exporter ]
		  ifAbsent: [
		  self exportAssertEquals: aFamixUTAssertion on: exporter ]
]

{ #category : #exporting }
FamixUTSUnitAssertionStrategy >> export: aFamixUTAssertion shouldRaise: error on: exporter [

	^ RBMessageNode
		  receiver: (RBVariableNode named: 'self')
		  selector: #should:raise:
		  arguments: {
				  (RBVariableNode named: 'actual').
				  (RBVariableNode named:
					   (error copyFrom: 1 to: (error indexOf: $:) - 1)) }
]

{ #category : #exporting }
FamixUTSUnitAssertionStrategy >> exportAssertEquals: aFamixUTAssertion on: exporter [

	^ RBMessageNode
		  receiver: (RBVariableNode named: 'self')
		  selector: #assert:equals:
		  arguments: {
				  (RBVariableNode named: 'actual').
				  (exporter valueExporter makeVariableExpression:
					   aFamixUTAssertion expected) }
]
