Class {
	#name : #FamixUTJUnitExporter,
	#superclass : #Object,
	#instVars : [
		'model',
		'valueExporter',
		'statements'
	],
	#category : #'Famix-UnitTest-Exporter'
}

{ #category : #api }
FamixUTJUnitExporter >> export: aFamixUTModel [

	(aFamixUTModel allWithType: FamixUTCase) do: [ :case | 
		self exportCase: case ].
	(aFamixUTModel allWithType: FamixUTSuite) do: [ :suite | 
		self exportSuite: suite ].
	^ self model
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportAct: aFamixUTAct [

	| testedMethod invocation |
	testedMethod := aFamixUTAct method testedMethod.
	invocation := self model newMethodInvocation
		              name: testedMethod name;
		              receiver: (model newNewExpression type:
					               (testedMethod parentType 
						                asFASTJavaTypeExpressionOn: model));
		              arguments:
			              (aFamixUTAct arguments collect: [ :argument | 
					               model newVariableExpression name:
							               (self valueExporter varNameFor: argument) ]).
	^ self statements addStatement:
		  (testedMethod declaredType name = 'void'
			   ifTrue: [ model newExpressionStatement expression: invocation ]
			   ifFalse: [ 
				   model newVarDeclStatement
					   type:
						   (testedMethod declaredType asFASTJavaTypeExpressionOn: model);
					   addDeclarator: (model newVariableDeclarator
							    variable: (model newVariableExpression name: 'actual');
							    expression: invocation);
					   yourself ])
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportAssertion: aFamixUTAssertion [

	^ self statements addStatement:
		  (self model newExpressionStatement expression:
			   (model newMethodInvocation
				    name: 'assertEquals';
				    addArgument: (model newVariableExpression name:
							     (self valueExporter varNameFor: aFamixUTAssertion expected));
				    addArgument: (model newVariableExpression name: 'actual');
				    yourself))
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportCase: aFamixUTCase [

	^ self model newClassDeclaration
		  name: aFamixUTCase testedClass name , 'Test';
		  addModifier: (model newModifier token: 'public');
		  declarations:
			  (aFamixUTCase methods collect: [ :method | 
					   self exportMethod: method ])
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportMethod: aFamixUTMethod [

	| method |
	method := self makeTestMethod: aFamixUTMethod.
	"Arrange/Given"
	aFamixUTMethod setUp ifNotNil: [ 
		self exportMethodSetUp: aFamixUTMethod setUp ].
	aFamixUTMethod act ifNotNil: [ 
		aFamixUTMethod act arguments do: [ :argument | 
			argument accept: self valueExporter ].
		"Act/When"
		self exportAct: aFamixUTMethod act ].
	"Assert/Then"
	aFamixUTMethod assertions do: [ :assertion | 
		self exportAssertion: assertion ].
	^ method
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportMethodSetUp: aFamixUTSetUp [

	aFamixUTSetUp values do: [ :value | value accept: self valueExporter ]
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportSetUp: aFamixUTSetUp [

	self shouldBeImplemented
]

{ #category : #api }
FamixUTJUnitExporter >> exportSuite: aFamixUTSuite [

	self shouldBeImplemented
]

{ #category : #ast }
FamixUTJUnitExporter >> makeTestMethod: aFamixUTMethod [

	self flag: 'Use FAMIX2Java instead of FAST?'.

	^ self model newMethodEntity
		  name: aFamixUTMethod name;
		  addModifier: (model newAnnotation expression:
					   (model newVariableExpression name: 'Test'));
		  addModifier: (model newModifier token: 'public');
		  type: model newVoidTypeExpression;
		  statementBlock: self newStatementBlock
]

{ #category : #accessing }
FamixUTJUnitExporter >> model [

	^ model ifNil: [ model := self valueExporter model ]
]

{ #category : #accessing }
FamixUTJUnitExporter >> model: aFASTJavaModel [

	self valueExporter model: (model := aFASTJavaModel)
]

{ #category : #'instance creation' }
FamixUTJUnitExporter >> newStatementBlock [

	self statements: self model newStatementBlock.
	^ statements
]

{ #category : #accessing }
FamixUTJUnitExporter >> statements [

	^ statements ifNil: [ statements := self valueExporter statements ]
]

{ #category : #accessing }
FamixUTJUnitExporter >> statements: aStatementCollection [

	self valueExporter statements: (statements := aStatementCollection)
]

{ #category : #accessing }
FamixUTJUnitExporter >> valueExporter [

	^ valueExporter ifNil: [ 
		  valueExporter := FamixValue2FASTJavaVisitor new ]
]
