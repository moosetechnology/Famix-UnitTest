Class {
	#name : 'FamixUTSUnitExporter',
	#superclass : 'FamixUTAbstractExporter',
	#category : 'Famix-UnitTest-Exporter-Exporters',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Exporters'
}

{ #category : 'accessing' }
FamixUTSUnitExporter >> assertionStrategy [

	^ assertionStrategy ifNil: [
		  assertionStrategy := FamixUTSUnitAssertionStrategy new ]
]

{ #category : 'exporting' }
FamixUTSUnitExporter >> exportAct: aFamixUTAct [
	"Execute the method under test"

	| invocation |
	invocation := self makeActInvocation: aFamixUTAct.
	self statementBlock addTemporaryNamed: 'actual'.
	^ self statementBlock addNode: (RBAssignmentNode
			   variable: (RBVariableNode named: 'actual')
			   value: invocation)
]

{ #category : 'exporting' }
FamixUTSUnitExporter >> exportAssertion: aFamixUTAssertion [

	aFamixUTAssertion expected resultInSpan tags
		at: 'error'
		ifPresent: [
			| actualBlock block |
			actualBlock := self statementBlock children last.
			block := RBBlockNode body:
				         (RBSequenceNode statements: { actualBlock value }).
			actualBlock replaceNode: actualBlock value withNode: block ].
	^ self statementBlock addNode:
		  (self assertionStrategy export: aFamixUTAssertion on: self)
]

{ #category : 'exporting' }
FamixUTSUnitExporter >> exportCase: aFamixUTCase [

	| name |
	name := aFamixUTCase testedClass name , 'ModestTest'.
	self class environment
		at: name asSymbol
		ifPresent: [ :class | currentClass := class ]
		ifAbsent: [ "create it, the installer will create the package if it does not exist"
			currentClass := self class classInstaller make: [ :builder |
				                builder
					                name: name;
					                superclass: TestCase;
					                package:
						                aFamixUTCase testedClass parentPackage name
							                asString , '-Tests';
					                comment:
						                (self writeCommentForTestClass: aFamixUTCase) ] ].

	aFamixUTCase methods do: [ :method |
		currentClass
			compile: (self exportMethod: method) formattedCode
			classified: 'tests' ].
	^ currentClass
]

{ #category : 'exporting' }
FamixUTSUnitExporter >> exportCaseCompilationUnit: aFamixUTCase [

	self exportCase: aFamixUTCase
]

{ #category : 'exporting' }
FamixUTSUnitExporter >> exportMethod: aFamixUTMethod [

	self statementBlock: self newStatementBlock.
	"Arrange/Given"
	aFamixUTMethod setUp ifNotNil: [ :setUp |
		self exportMethodSetUp: setUp ].
	"Act/When"
	aFamixUTMethod act ifNotNil: [ :act |
		self exportAct: aFamixUTMethod act ].
	"Assert/Then"
	aFamixUTMethod assertions do: [ :assertion |
		self exportAssertion: assertion ].
	"Teardown"
	aFamixUTMethod tearDown ifNotNil: [ :tearDown |
		self exportMethodTearDown: tearDown ].

	^ self makeTestMethod: aFamixUTMethod
]

{ #category : 'exporting' }
FamixUTSUnitExporter >> exportMethodSetUp: aFamixUTSetUp [

	(self methodSetUpStrategy export: aFamixUTSetUp on: self)
		with: aFamixUTSetUp values
		do: [ :ast :value |
			| node |
			node := ast.

			((ast isMessage and: [ ast receiver name = #self ]) or: [
				 ast isLiteralNode or: [ ast isAssignment ] ]) ifFalse: [ "When not calling a helper or evaluating to a literal"
				self flag: #TODO. "A dict is used to hold vars in helpers, because there can be too many.
				This is implemented in `makeVariableNamed:` which returns `dict at: #varName` (that's a hack!).
				However, now we write the test itself, and we only care about the var name."
				statementBlock statements: statementBlock statements allButLast. "Remove the dict access"
				node := ast arguments second "Keep the var value" ].

			self statementBlock addNode: (ast isAssignment
					 ifTrue: [ ast ]
					 ifFalse: [
						 RBAssignmentNode
							 variable:
							 (RBVariableNode named: (self valueExporter varNameFor: value))
							 value: node ]) ]
]

{ #category : 'instance creation' }
FamixUTSUnitExporter >> exportMethodTearDown: aFamixUTTearDown [

	self shouldBeImplemented
]

{ #category : 'instance creation' }
FamixUTSUnitExporter >> exportSetUp: aFamixUTSetUp [

	self shouldBeImplemented
]

{ #category : 'exporting' }
FamixUTSUnitExporter >> finalizeHelpers [
	"Nothing to do"
]

{ #category : 'exporting' }
FamixUTSUnitExporter >> makeActInvocation: aFamixUTAct [

	| testedMethod |
	testedMethod := aFamixUTAct method testedMethod.
	^ RBMessageNode
		  receiver: (aFamixUTAct receiver
				   ifNil: [ self makeActReceiver: testedMethod ]
				   ifNotNil: [ :receiver |
				   self valueExporter makeVariableExpression: receiver ])
		  selector: testedMethod name
		  arguments: (aFamixUTAct arguments collect: [ :argument |
				   self valueExporter makeVariableExpression: argument value ])
]

{ #category : 'exporting' }
FamixUTSUnitExporter >> makeActReceiver: testedMethod [

	^ model newNewExpression type:
		  (testedMethod parentType asFASTJavaTypeExpressionOn:
			   self valueExporter)
]

{ #category : 'ast' }
FamixUTSUnitExporter >> makeArrangeComment [

	^ self model newComment content: '/* ARRANGE */'
]

{ #category : 'ast' }
FamixUTSUnitExporter >> makeAssertComment [

	^ self model newComment content: '/* ASSERT */'
]

{ #category : 'ast' }
FamixUTSUnitExporter >> makeTestCaseComment [
	"Comment aying the tests are generated by Modest and when."

	^ model newComment content:
		  '"author Generated by https://github.com/Evref-BL/Modest'
		  , String lf , 'version: ' , DateAndTime now asString , '"'
]

{ #category : 'ast' }
FamixUTSUnitExporter >> makeTestMethod: aFamixUTMethod [
	"Create missing temporary variables"

	statementBlock allChildren do: [ :each |
		each isAssignment ifTrue: [
			(statementBlock temporaries anySatisfy: [ :temporary |
				 temporary name = each variable name ]) ifFalse: [
				statementBlock addTemporaryNamed: each variable name ] ] ].
	^ RBMethodNode selector: aFamixUTMethod name body: statementBlock
]

{ #category : 'exporting' }
FamixUTSUnitExporter >> methodSetUpStrategy [

	^ methodSetUpStrategy ifNil: [
		  methodSetUpStrategy := FamixUTPharoHelperSetUpStrategy instance ]
]

{ #category : 'mass units' }
FamixUTSUnitExporter >> newStatementBlock [

	self statementBlock: RBSequenceNode new.
	^ statementBlock
]

{ #category : 'instance creation' }
FamixUTSUnitExporter >> newValueExporter [

	^ FamixValue2PharoVisitor new
]

{ #category : 'ast' }
FamixUTSUnitExporter >> writeCommentForTestClass: aFamixUTCase [

	^ String streamContents: [ :stream |
		  | name |
		  name := aFamixUTCase name.
		  name first isVowel
			  ifTrue: [ stream nextPutAll: 'An ' ]
			  ifFalse: [ stream nextPutAll: 'A ' ].
		  stream
			  nextPutAll: name;
			  nextPutAll: ' is a test class for testing the behavior of ';
			  nextPutAll: aFamixUTCase testedClass name ]
]
