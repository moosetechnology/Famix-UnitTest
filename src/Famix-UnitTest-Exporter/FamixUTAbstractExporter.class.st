Class {
	#name : 'FamixUTAbstractExporter',
	#superclass : 'Object',
	#instVars : [
		'valueExporter',
		'model',
		'mapping',
		'statementBlock',
		'assertionStrategy',
		'methodSetUpStrategy',
		'caseSuperclass',
		'currentClass',
		'patches'
	],
	#category : 'Famix-UnitTest-Exporter-Exporters',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Exporters'
}

{ #category : 'testing' }
FamixUTAbstractExporter class >> isAbstract [

	^ self == FamixUTAbstractExporter
]

{ #category : 'accessing' }
FamixUTAbstractExporter >> assertionStrategy [

	^ assertionStrategy
]

{ #category : 'accessing' }
FamixUTAbstractExporter >> assertionStrategy: aFamixUTAssertionStrategy [

	assertionStrategy := aFamixUTAssertionStrategy
]

{ #category : 'accessing' }
FamixUTAbstractExporter >> caseSuperclass [

	^ caseSuperclass
]

{ #category : 'accessing' }
FamixUTAbstractExporter >> caseSuperclass: aClassName [
	"Call `initializeWith:` to find the corresponding Famix Class entity."

	caseSuperclass := aClassName
]

{ #category : 'accessing' }
FamixUTAbstractExporter >> currentClass [

	^ currentClass
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> export: aFamixUTModel [

	self patchBeforeExport: aFamixUTModel.
	self patchBeforeTestCasesExport: aFamixUTModel.
	(aFamixUTModel allWithType: FamixUTCase) do: [ :case |
		self exportCaseCompilationUnit: case ].
	self patchAfterTestCasesExport: aFamixUTModel.

	self patchBeforeTestSuitesExport: aFamixUTModel.
	(aFamixUTModel allWithType: FamixUTSuite) do: [ :suite |
		self exportSuite: suite ].
	self patchAfterTestSuitesExport: aFamixUTModel.

	self finalizeHelpers.
	self patchAfterExport: aFamixUTModel.
	^ self model
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> exportAct: aFamixUTAct [

	self subclassResponsibility
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> exportAssertion: aFamixUTAssertion [

	^ self statementBlock addStatement:
		  (self assertionStrategy export: aFamixUTAssertion on: self)
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> exportCase: aFamixUTCase [
	"Returns the AST of the test class represented by the given Case entity."

	| case |
	(case := self model newClassDeclaration)
		name: aFamixUTCase name;
		addComment: self makeTestCaseComment.
	aFamixUTCase methods do: [ :method |
		case addDeclaration: (self exportMethod: method) ].
	^ case
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> exportCaseCompilationUnit: aFamixUTCase [

	self subclassResponsibility
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> exportMethod: aFamixUTMethod [

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

{ #category : 'exporting' }
FamixUTAbstractExporter >> exportMethodTearDown: aFamixUTTearDown [

	self subclassResponsibility
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> exportSuite: aFamixUTSuite [

	self subclassResponsibility
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> finalizeHelpers [

	self valueExporter finalizeHelpers.
	self methodSetUpStrategy helpers do: [ :helper |
		helper compilationUnit importDeclarations:
			self valueExporter builder makeImportDeclarations
			, (self valueExporter objectExportStrategy dependencyImportsOn:
					 self model) ]
]

{ #category : 'initialization' }
FamixUTAbstractExporter >> initializeWith: aFamixEntityFinder [
	"Use the finder to resolve the case superclass name to the corresponding Famix class."

	caseSuperclass ifNotNil: [
		caseSuperclass := aFamixEntityFinder findTypeNamed: caseSuperclass ]
]

{ #category : 'ast' }
FamixUTAbstractExporter >> makeActComment [

	self subclassResponsibility
]

{ #category : 'ast' }
FamixUTAbstractExporter >> makeArrangeComment [

	self subclassResponsibility
]

{ #category : 'ast' }
FamixUTAbstractExporter >> makeAssertComment [

	self subclassResponsibility
]

{ #category : 'ast' }
FamixUTAbstractExporter >> makeTestCaseComment [
	"Inform that this class was generated."

	self subclassResponsibility
]

{ #category : 'ast' }
FamixUTAbstractExporter >> makeTestMethod: aFamixUTMethod [

	^ self model newMethodEntity name: aFamixUTMethod name
]

{ #category : 'accessing' }
FamixUTAbstractExporter >> mapping [
	"Return the mapping of the generated AST structure"

	^ mapping ifNil: [ mapping := FamixUTModelMapping new ]
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> methodSetUpStrategy [

	^ methodSetUpStrategy ifNil: [
		  methodSetUpStrategy := FamixUTAbstractSetUpStrategy default ]
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> methodSetUpStrategy: aFamixUTArrangeStrategy [

	methodSetUpStrategy := aFamixUTArrangeStrategy
]

{ #category : 'accessing' }
FamixUTAbstractExporter >> model [

	^ model ifNil: [ model := self valueExporter model ]
]

{ #category : 'accessing' }
FamixUTAbstractExporter >> model: aFASTModel [

	self valueExporter model: (model := aFASTModel)
]

{ #category : 'instance creation' }
FamixUTAbstractExporter >> newValueExporter [

	self subclassResponsibility
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> patchAfterExport: aFamixUTModel [

	self patches do: [ :patch | patch after: self exports: aFamixUTModel ]
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> patchAfterTestCasesExport: aFamixUTModel [

	self patches do: [ :patch |
		patch after: self exportsTestCases: aFamixUTModel ]
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> patchAfterTestSuitesExport: aFamixUTModel [

	self patches do: [ :patch |
		patch after: self exportsTestSuites: aFamixUTModel ]
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> patchBeforeExport: aFamixUTModel [

	self patches do: [ :patch |
		patch before: self exports: aFamixUTModel ]
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> patchBeforeTestCasesExport: aFamixUTModel [

	self patches do: [ :patch |
		patch before: self exportsTestCases: aFamixUTModel ]
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> patchBeforeTestSuitesExport: aFamixUTModel [

	self patches do: [ :patch |
		patch before: self exportsTestSuites: aFamixUTModel ]
]

{ #category : 'hooks' }
FamixUTAbstractExporter >> patchTestCaseBuilt: aFamixUTCase [

	self patches do: [ :patch |
		patch when: self builtTestCase: aFamixUTCase ]
]

{ #category : 'hooks' }
FamixUTAbstractExporter >> patchTestCaseCreated: aFamixUTCase [

	self patches do: [ :patch |
		patch when: self createdTestCase: aFamixUTCase ]
]

{ #category : 'exporting' }
FamixUTAbstractExporter >> patchTestCaseRemoved: aFamixUTCase [

	self patches do: [ :patch |
		patch when: self removedTestCase: aFamixUTCase ]
]

{ #category : 'hooks' }
FamixUTAbstractExporter >> patchTestMethodSkipped: aFamixUTMethod because: exception [

	self patches do: [ :patch |
		patch
			when: self
			skippedTestMethod: aFamixUTMethod
			because: exception ]
]

{ #category : 'accessing' }
FamixUTAbstractExporter >> patches [

	^ patches ifNil: [ patches := Array empty ]
]

{ #category : 'accessing' }
FamixUTAbstractExporter >> patches: aPatchCollection [

	patches := aPatchCollection
]

{ #category : 'accessing' }
FamixUTAbstractExporter >> statementBlock [

	^ statementBlock ifNil: [
		  statementBlock := self valueExporter statementBlock ]
]

{ #category : 'accessing' }
FamixUTAbstractExporter >> statementBlock: aStatementSequence [

	self valueExporter statementBlock:
		(statementBlock := aStatementSequence)
]

{ #category : 'accessing' }
FamixUTAbstractExporter >> valueExporter [

	^ valueExporter ifNil: [ valueExporter := self newValueExporter ]
]

{ #category : 'accessing' }
FamixUTAbstractExporter >> valueExporter: aFamixValue2ASTVisitor [

	valueExporter := aFamixValue2ASTVisitor
]
