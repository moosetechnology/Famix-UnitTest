Class {
	#name : #FamixPharoUTHelperSetUpStrategy,
	#superclass : #FamixUTAbstractSetUpStrategy,
	#category : #'Famix-UnitTest-Exporter-Strategies'
}

{ #category : #exporting }
FamixPharoUTHelperSetUpStrategy >> export: aFamixUTSetUp on: aFamixUTExporter [

	| model valueExporter |
	aFamixUTSetUp values ifEmpty: [ ^ self ].
	model := aFamixUTExporter model.
	valueExporter := aFamixUTExporter valueExporter.
	"Only make helper if necessary => at least one non-empty object, collection or dictionary."
	^ aFamixUTSetUp values collect: [ :value |
		  ((value isOfObject or: [
			    value isOfCollection or: [ value isOfDictionary ] ]) and: [
			   value value isNotEmpty ])
			  ifFalse: [ value accept: valueExporter ]
			  ifTrue: [
				  | methodName |
				  methodName := ((WriteStream with: 'given_')
				                 <<
					                 (value resultInSpan
						                  ifNotNil: [ 'expected' ]
						                  ifNil: [
							                  value receiverInSpan
								                  ifNotNil: [ 'receiver' ]
								                  ifNil: [
								                  value typedEntity name , '_argument' ] ])
				                 << '_for_' << aFamixUTSetUp method name) contents.

				  aFamixUTExporter currentClass
					  compile:
						  ((self makeHelperMethodFor: value on: aFamixUTExporter)
							   selector: methodName) formattedCode
					  classified: 'helpers'.

				  "IMPORTANT: build the method before calling it and assigning it to the variable,
				because a value is considered already exported if it has been named!"
				  RBMessageNode
					  receiver: (RBVariableNode named: #self)
					  selector: methodName ] ]
]

{ #category : #exporting }
FamixPharoUTHelperSetUpStrategy >> makeHelperMethodFor: value on: aFamixUTExporter [
	"Export the value inside the helper method, then restore the previous context."

	| model valueExporter method oldStatementBlock newStatementBlock node |
	model := aFamixUTExporter model.
	valueExporter := aFamixUTExporter valueExporter.
	oldStatementBlock := valueExporter statementBlock.
	method := RBMethodNode new body:
		          (newStatementBlock := RBSequenceNode new).
	node := (valueExporter statementBlock: newStatementBlock)
		        ensureVisited: value.
	newStatementBlock addNode:
		(((node isMessage and: [ node receiver isAssignment ]) or: [
			  node isCascade and: [ node messages first receiver isAssignment ] ])
			 ifTrue: [ node ]
			 ifFalse: [
				 RBAssignmentNode new
					 value: node;
					 variable: (RBVariableNode named:
								  (aFamixUTExporter valueExporter varNameFor: value)) ]).

	newStatementBlock addNode:
		(RBReturnNode value: (valueExporter makeVariableExpression: value)).
	"Add necessary temporary variables"
	newStatementBlock allChildren do: [ :each |
		each isAssignment ifTrue: [
			(newStatementBlock temporaries anySatisfy: [ :temporary |
				 temporary name = each variable name ]) ifFalse: [
				newStatementBlock addTemporaryNamed: each variable name ] ] ].
	valueExporter statementBlock: oldStatementBlock.
	^ method
]
