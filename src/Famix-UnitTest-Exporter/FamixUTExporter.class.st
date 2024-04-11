Class {
	#name : #FamixUTExporter,
	#superclass : #Object,
	#instVars : [
		'valueExporter',
		'model',
		'statementBlock',
		'assertionStrategy',
		'methodSetUpStrategy'
	],
	#category : #'Famix-UnitTest-Exporter-Exporters'
}

{ #category : #testing }
FamixUTExporter class >> isAbstract [

	^ self == FamixUTExporter
]

{ #category : #exporting }
FamixUTExporter >> assertionStrategy [

	^ assertionStrategy
]

{ #category : #exporting }
FamixUTExporter >> export: aFamixUTModel [

	(aFamixUTModel allWithType: FamixUTCase) do: [ :case |
		self exportCaseFile: case ].
	(aFamixUTModel allWithType: FamixUTSuite) do: [ :suite |
		self exportSuite: suite ].
	self valueExporter makeHelper.
	^ self model
]

{ #category : #exporting }
FamixUTExporter >> exportAct: aFamixUTAct [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTExporter >> exportAssertion: aFamixUTAssertion [

	^ self statementBlock addStatement:
		  (self assertionStrategy export: aFamixUTAssertion on: self)
]

{ #category : #exporting }
FamixUTExporter >> exportCase: aFamixUTCase [

	| case |
	(case := self model newClassDeclaration)
		name: aFamixUTCase name;
		addComment: self makeTestCaseComment.
	aFamixUTCase methods do: [ :method |
		case addDeclaration: (self exportMethod: method) ].
	^ case
]

{ #category : #exporting }
FamixUTExporter >> exportCaseFile: aFamixUTCase [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTExporter >> exportMethod: aFamixUTMethod [

	| method |
	method := self makeTestMethod: aFamixUTMethod.
	"Arrange/Given"
	aFamixUTMethod setUp ifNotNil: [ :setUp |
		self methodSetUpStrategy export: setUp on: self.
		self statementBlock statements ifNotEmpty: [ :statements |
			statements first addComment: self makeArrangeComment ] ].
	"Act/When"
	aFamixUTMethod act ifNotNil: [ :act |
		(self exportAct: aFamixUTMethod act) addComment: self makeActComment ].
	"Assert/Then"
	aFamixUTMethod assertions do: [ :assertion |
		(self exportAssertion: assertion) addComment: self makeAssertComment ].
	"Teardown"
	aFamixUTMethod tearDown ifNotNil: [ :tearDown |
		self exportMethodTearDown: tearDown ].
	^ method
]

{ #category : #exporting }
FamixUTExporter >> exportMethodTearDown: aFamixUTTearDown [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTExporter >> exportSuite: aFamixUTSuite [

	self subclassResponsibility
]

{ #category : #ast }
FamixUTExporter >> makeActComment [

	self subclassResponsibility
]

{ #category : #ast }
FamixUTExporter >> makeArrangeComment [

	self subclassResponsibility
]

{ #category : #ast }
FamixUTExporter >> makeAssertComment [

	self subclassResponsibility
]

{ #category : #ast }
FamixUTExporter >> makeTestCaseComment [
	"Inform that this class was generated."

	self subclassResponsibility
]

{ #category : #ast }
FamixUTExporter >> makeTestMethod: aFamixUTMethod [

	^ self model newMethodEntity name: aFamixUTMethod name
]

{ #category : #exporting }
FamixUTExporter >> methodSetUpStrategy [

	^ methodSetUpStrategy ifNil: [
		  methodSetUpStrategy := FamixUTSetUpStrategy default ]
]

{ #category : #exporting }
FamixUTExporter >> methodSetUpStrategy: aFamixUTArrangeStrategy [

	methodSetUpStrategy := aFamixUTArrangeStrategy
]

{ #category : #accessing }
FamixUTExporter >> model [

	^ model ifNil: [ model := self valueExporter model ]
]

{ #category : #accessing }
FamixUTExporter >> model: aFASTModel [

	self valueExporter model: (model := aFASTModel)
]

{ #category : #'instance creation' }
FamixUTExporter >> newValueExporter [

	self subclassResponsibility
]

{ #category : #accessing }
FamixUTExporter >> statementBlock [

	^ statementBlock ifNil: [
		  statementBlock := self valueExporter statementBlock ]
]

{ #category : #accessing }
FamixUTExporter >> statementBlock: aStatementSequence [

	self valueExporter statementBlock:
		(statementBlock := aStatementSequence)
]

{ #category : #accessing }
FamixUTExporter >> valueExporter [

	^ valueExporter ifNil: [ valueExporter := self newValueExporter ]
]

{ #category : #accessing }
FamixUTExporter >> valueExporter: aFamixValue2ASTVisitor [

	valueExporter := aFamixValue2ASTVisitor
]
