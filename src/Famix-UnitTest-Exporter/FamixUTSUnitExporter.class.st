Class {
	#name : #FamixUTSUnitExporter,
	#superclass : #FamixUTAbstractExporter,
	#category : #'Famix-UnitTest-Exporter-Exporters'
}

{ #category : #ast }
FamixUTSUnitExporter >> addNewCommentForTestClass: aClass basedOn: baseClass [

	aClass comment: (String streamContents: [ :stream |
			 | name |
			 name := aClass name.
			 name first isVowel
				 ifTrue: [ stream nextPutAll: 'An ' ]
				 ifFalse: [ stream nextPutAll: 'A ' ].
			 stream
				 nextPutAll: name;
				 nextPutAll: ' is a test class for testing the behavior of ';
				 nextPutAll: baseClass name ])
]

{ #category : #exporting }
FamixUTSUnitExporter >> assertionStrategy [

	^ assertionStrategy ifNil: [
		  assertionStrategy := FamixUTSUnitAssertionStrategy new ]
]

{ #category : #exporting }
FamixUTSUnitExporter >> assertionStrategy: aFamixUTAssertionStrategy [

	assertionStrategy := aFamixUTAssertionStrategy
]

{ #category : #exporting }
FamixUTSUnitExporter >> export: aFamixUTModel [

	(aFamixUTModel allWithType: FamixUTCase) do: [ :case |
		self exportCaseFile: case ].
	(aFamixUTModel allWithType: FamixUTSuite) do: [ :suite |
		self exportSuite: suite ].
	self valueExporter makeHelper.
	^ self model
]

{ #category : #exporting }
FamixUTSUnitExporter >> exportAct: aFamixUTAct [
	"Execute the method under test"

	| invocation |
	invocation := self makeActInvocation: aFamixUTAct.
	self statementBlock addTemporaryNamed: 'actual'.
	^ self statementBlock addNode: (RBAssignmentNode
			   variable: (RBVariableNode named: 'actual')
			   value: invocation)
]

{ #category : #exporting }
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

{ #category : #exporting }
FamixUTSUnitExporter >> exportCase: aFamixUTCase [

	| currentClass systemEnvironment name |
	name := aFamixUTCase testedClass name , 'ModestTest'.
	systemEnvironment := ClySystemEnvironment currentImage.
	systemEnvironment
		classNamed: name
		ifPresent: [ :class | currentClass := class ]
		ifAbsent: [
			systemEnvironment ensureExistAndRegisterPackageNamed:
				aFamixUTCase testedClass parentPackage name asString , '-Tests'.

			currentClass := self class classInstaller make: [ :aBuilder |
				                aBuilder
					                name: name;
					                superclass: TestCase;
					                package:
						                (self newTestClassCategoryFor:
								                 aFamixUTCase testedClass) ].

			self addNewCommentForTestClass: currentClass basedOn: aFamixUTCase ].

	aFamixUTCase methods do: [ :method |
		currentClass
			compile: (self exportMethod: method) formattedCode
			classified: 'tests' ].
	^ currentClass
]

{ #category : #exporting }
FamixUTSUnitExporter >> exportCaseFile: aFamixUTCase [

	self exportCase: aFamixUTCase
]

{ #category : #exporting }
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

{ #category : #exporting }
FamixUTSUnitExporter >> exportMethodSetUp: aFamixUTSetUp [

	(self methodSetUpStrategy export: aFamixUTSetUp on: self)
		with: aFamixUTSetUp values
		do: [ :ast :value |
			| name |
			name := self valueExporter varNameDict
				        at: value
				        ifAbsentPut: [ valueExporter varNameFor: value ].
			self statementBlock addTemporaryNamed: name.
			self statementBlock addNode:
				(RBAssignmentNode
					 variable: (RBVariableNode named: name)
					 value: ast) ]
]

{ #category : #'instance creation' }
FamixUTSUnitExporter >> exportMethodTearDown: aFamixUTTearDown [

	self shouldBeImplemented
]

{ #category : #'instance creation' }
FamixUTSUnitExporter >> exportSetUp: aFamixUTSetUp [

	self shouldBeImplemented
]

{ #category : #exporting }
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
				   self valueExporter makeVariableExpression: argument ])
]

{ #category : #exporting }
FamixUTSUnitExporter >> makeActReceiver: testedMethod [

	^ model newNewExpression type:
		  (testedMethod parentType asFASTJavaTypeExpressionOn:
			   self valueExporter)
]

{ #category : #ast }
FamixUTSUnitExporter >> makeArrangeComment [

	^ self model newComment content: '/* ARRANGE */'
]

{ #category : #ast }
FamixUTSUnitExporter >> makeAssertComment [

	^ self model newComment content: '/* ASSERT */'
]

{ #category : #ast }
FamixUTSUnitExporter >> makeTestCaseComment [
	"Comment aying the tests are generated by Modest and when."

	^ model newComment content:
		  '"author Generated by https://github.com/Evref-BL/Modest'
		  , String lf , 'version: ' , DateAndTime now asString , '"'
]

{ #category : #exporting }
FamixUTSUnitExporter >> makeTestCaseReceiver: aFamixUTCase [

	self shouldBeImplemented
]

{ #category : #ast }
FamixUTSUnitExporter >> makeTestMethod: aFamixUTMethod [

	^ RBMethodNode selector: aFamixUTMethod name body: statementBlock
]

{ #category : #'mass units' }
FamixUTSUnitExporter >> newStatementBlock [

	self statementBlock: RBSequenceNode new.
	^ statementBlock
]

{ #category : #ast }
FamixUTSUnitExporter >> newTestClassCategoryFor: aClass [

	^ String streamContents: [ :s |
		  s
			  nextPutAll: aClass parentPackage name;
			  nextPutAll: '-Tests' ]
]

{ #category : #'instance creation' }
FamixUTSUnitExporter >> newValueExporter [

	^ FamixValue2PharoVisitor new
]
