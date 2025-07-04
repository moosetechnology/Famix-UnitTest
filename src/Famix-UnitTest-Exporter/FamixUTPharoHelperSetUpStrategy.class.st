Class {
	#name : 'FamixUTPharoHelperSetUpStrategy',
	#superclass : 'FamixUTAbstractSetUpStrategy',
	#category : 'Famix-UnitTest-Exporter-Strategies',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Strategies'
}

{ #category : 'exporting' }
FamixUTPharoHelperSetUpStrategy >> export: aFamixUTSetUp helperFor: value on: aFamixUTExporter [

	| testName helperName helperMethod |
	testName := aFamixUTSetUp method name.
	helperName := ((WriteStream with: 'given_')
	               <<
		               (value resultInSpan
			                ifNotNil: [ 'expected' ]
			                ifNil: [
				                value receiverInSpan
					                ifNotNil: [ 'receiver' ]
					                ifNil: [ value typedEntity name , '_argument' ] ])
	               << '_for_' << testName) contents.

	helperMethod := (self makeHelperMethodFor: value on: aFamixUTExporter)
		                selector: helperName.

	"Add the helper to the method mapping"
	((aFamixUTExporter mapping atClass: aFamixUTSetUp method case)
		 methodNamed: testName) addHelper: helperMethod named: helperName.

	"IMPORTANT: build the method before calling it and assigning it to the variable,
	because a value is considered already exported if it has been named!"
	^ RBMessageNode
		  receiver: (RBVariableNode named: #self)
		  selector: helperName
]

{ #category : 'exporting' }
FamixUTPharoHelperSetUpStrategy >> export: aFamixUTSetUp on: aFamixUTExporter [

	| valueExporter |
	aFamixUTSetUp values ifEmpty: [ ^ self ].
	valueExporter := aFamixUTExporter valueExporter.

	"Only make helper if necessary => at least one non-empty object, collection or dictionary."
	^ aFamixUTSetUp values collect: [ :value |
		  ((value isOfObject or: [
			    value isOfCollection or: [ value isOfDictionary ] ]) and: [
			   value value isNotEmpty ])
			  ifFalse: [ "The value is rebuilt in the test directly"
				  valueExporter useTempVarsDuring: [ value accept: valueExporter ] ]
			  ifTrue: [ "Make and call a helper method"
				  self export: aFamixUTSetUp helperFor: value on: aFamixUTExporter ] ]
]

{ #category : 'exporting' }
FamixUTPharoHelperSetUpStrategy >> makeHelperMethodFor: value on: aFamixUTExporter [
	"Export the value inside the helper method, then restore the previous context."

	| model valueExporter method oldStatementBlock newStatementBlock node |
	model := aFamixUTExporter model.
	valueExporter := aFamixUTExporter valueExporter.
	oldStatementBlock := valueExporter statementBlock.
	method := RBMethodNode new body:
		          (newStatementBlock := RBSequenceNode new).

	"Create a dictionary that will contain all of the temporary variables"
	newStatementBlock addNode: (RBAssignmentNode
			 variable: (RBVariableNode named: 'vars')
			 value: (RBMessageNode
					  receiver: (RBVariableNode named: #Dictionary)
					  selector: #new)).

	"Export the value in a new method context"
	node := (valueExporter statementBlock: newStatementBlock)
		        ensureVisited: value.

	"Last statement returns the value built by the helper"
	newStatementBlock addNode: (RBReturnNode value: (RBMessageNode
				  receiver: (RBVariableNode named: 'vars')
				  selector: #at:
				  arguments:
				  { (RBLiteralNode value: (valueExporter varNameFor: value)) })).

	"Add necessary temporary variables"
	newStatementBlock allChildren do: [ :each |
		each isAssignment ifTrue: [
			(newStatementBlock temporaries anySatisfy: [ :temporary |
				 temporary name = each variable name ]) ifFalse: [
				newStatementBlock addTemporaryNamed: each variable name ] ] ].

	valueExporter statementBlock: oldStatementBlock. "Restore previous context"
	^ method
]
