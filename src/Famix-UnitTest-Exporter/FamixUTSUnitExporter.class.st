Class {
	#name : 'FamixUTSUnitExporter',
	#superclass : 'FamixUTAbstractExporter',
	#category : 'Famix-UnitTest-Exporter-Exporters',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Exporters'
}

{ #category : 'exporting' }
FamixUTSUnitExporter >> assertionStrategy [

	^ assertionStrategy ifNil: [
		  assertionStrategy := FamixUTSUnitAssertionStrategy new ]
]

{ #category : 'exporting' }
FamixUTSUnitExporter >> assertionStrategy: aFamixUTAssertionStrategy [

	assertionStrategy := aFamixUTAssertionStrategy
]

{ #category : 'exporting' }
FamixUTSUnitExporter >> export: aFamixUTModel [

	(aFamixUTModel allWithType: FamixUTCase) do: [ :case |
		self exportCaseFile: case ].
	(aFamixUTModel allWithType: FamixUTSuite) do: [ :suite |
		self exportSuite: suite ].
	self valueExporter makeHelper.
	^ self model
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
FamixUTSUnitExporter >> exportCaseFile: aFamixUTCase [

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
			| name node |
			node := ast.
			((ast isMessage and: [ ast receiver name = #self ]) or: [
				 ast isLiteralNode ]) ifFalse: [
				self flag: #TODO. "prevent this from happening"
				statementBlock statements: statementBlock statements allButLast.
				node := ast arguments second ].
			name := self valueExporter varNameFor: value.
			self statementBlock addNode:
				(RBAssignmentNode
					 variable: (RBVariableNode named: name)
					 value: node) ]
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

{ #category : 'exporting' }
FamixUTSUnitExporter >> makeTestCaseReceiver: aFamixUTCase [

	self shouldBeImplemented
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
		  methodSetUpStrategy := FamixPharoUTHelperSetUpStrategy instance ]
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
