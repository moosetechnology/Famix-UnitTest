Class {
	#name : #FamixUTAbstractExporter,
	#superclass : #Object,
	#instVars : [
		'valueExporter',
		'model',
		'statements'
	],
	#category : #'Famix-UnitTest-Exporter'
}

{ #category : #exporting }
FamixUTAbstractExporter >> export: aFamixUTModel [

	(aFamixUTModel allWithType: FamixUTCase) do: [ :case | 
		self exportCaseFile: case ].
	(aFamixUTModel allWithType: FamixUTSuite) do: [ :suite | 
		self exportSuite: suite ].
	^ self model
]

{ #category : #exporting }
FamixUTAbstractExporter >> exportAct: aFamixUTAct [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTAbstractExporter >> exportAssertion: aFamixUTAssertion [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTAbstractExporter >> exportCase: aFamixUTCase [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTAbstractExporter >> exportCaseFile: aFamixUTCase [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTAbstractExporter >> exportMethod: aFamixUTMethod [

	| method |
	method := self makeTestMethod: aFamixUTMethod.
	"Arrange/Given"
	aFamixUTMethod setUp ifNotNil: [ :setUp | 
		self exportMethodSetUp: setUp ].
	aFamixUTMethod act ifNotNil: [ :act | 
		act arguments do: [ :argument | argument accept: self valueExporter ].
		"Act/When"
		self exportAct: aFamixUTMethod act ].
	"Assert/Then"
	aFamixUTMethod assertions do: [ :assertion | 
		self exportAssertion: assertion ].
	aFamixUTMethod tearDown ifNotNil: [ :tearDown | 
		self exportMethodTearDown: tearDown ].
	^ method
]

{ #category : #exporting }
FamixUTAbstractExporter >> exportMethodSetUp: aFamixUTSetUp [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTAbstractExporter >> exportMethodTearDown: aFamixUTTearDown [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTAbstractExporter >> exportSuite: aFamixUTSuite [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTAbstractExporter >> makeTestMethod: aFamixUTMethod [

	self subclassResponsibility
]

{ #category : #accessing }
FamixUTAbstractExporter >> model [

	^ model ifNil: [ model := self valueExporter model ]
]

{ #category : #accessing }
FamixUTAbstractExporter >> model: aFASTModel [

	self valueExporter model: (model := aFASTModel)
]

{ #category : #accessing }
FamixUTAbstractExporter >> newValueExporter [

	self subclassResponsibility
]

{ #category : #accessing }
FamixUTAbstractExporter >> statements [

	^ statements ifNil: [ statements := self valueExporter statements ]
]

{ #category : #accessing }
FamixUTAbstractExporter >> statements: aStatementSequence [

	self valueExporter statements: (statements := aStatementSequence)
]

{ #category : #accessing }
FamixUTAbstractExporter >> valueExporter [

	^ valueExporter ifNil: [ valueExporter := self newValueExporter ]
]
