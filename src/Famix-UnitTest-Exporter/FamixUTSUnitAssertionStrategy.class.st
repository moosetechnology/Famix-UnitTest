Class {
	#name : #FamixUTSUnitAssertionStrategy,
	#superclass : #FamixUTAbstractStrategy,
	#category : #'Famix-UnitTest-Exporter-Exporters'
}

{ #category : #exporting }
FamixUTSUnitAssertionStrategy >> export: aFamixUTAssertion on: exporter [

	^ RBMessageNode
		  receiver: (RBVariableNode named: 'self')
		  selector: #assert:equals:
		  arguments: {
				  (RBVariableNode named: 'actual').
				  (exporter valueExporter makeVariableExpression:
					   aFamixUTAssertion expected) }
]
