Class {
	#name : #FamixUTJUnitExporter,
	#superclass : #Object,
	#instVars : [
		'model',
		'valueExporter'
	],
	#category : #'Famix-UnitTest-Exporter'
}

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
	^ testedMethod declaredType name = 'void'
		  ifTrue: [ model newExpressionStatement expression: invocation ]
		  ifFalse: [ 
			  model newVarDeclStatement
				  type:
					  (testedMethod declaredType asFASTJavaTypeExpressionOn: model);
				  addDeclarator: (model newVariableDeclarator
						   variable: (model newVariableExpression name: 'actual');
						   expression: invocation);
				  yourself ]
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportAssertion: aFamixUTAssertion [

	^ self model newExpressionStatement expression:
		  (model newMethodInvocation
			   name: 'assertEquals';
			   addArgument: (model newVariableExpression name: 'expected');
			   addArgument: (model newVariableExpression name: 'actual');
			   yourself)
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

	| method statements |
	method := self model newMethodEntity
		          name: (aFamixUTMethod name ifNil: [ 
					           'test' , aFamixUTMethod testedMethod name capitalized ]);
		          addModifier: (model newAnnotation expression:
					           (model newVariableExpression name: 'Test'));
		          addModifier: (model newModifier token: 'public');
		          type: model newVoidTypeExpression;
		          statementBlock: (statements := model newStatementBlock).
	"Arrange/Given"
	aFamixUTMethod setUp ifNotNil: [ 
		statements addStatement: (self exportSetUp: aFamixUTMethod setUp) ].
	"aFamixUTMethod result ifNotNil: [ 
		model newVarDeclStatement
			type: (aFamixUTMethod act result asFASTJavaTypeExpressionOn:
						 self valueExporter);
			addDeclarator: (model newVariableDeclarator);
			yourself ]."
	aFamixUTMethod act ifNotNil: [ 
		aFamixUTMethod act arguments do: [ :argument | 
			(argument accept: self valueExporter) statements do: [ :statement | 
				statements addStatement: statement ] ].
		"Act/When"
		statements addStatement: (self exportAct: aFamixUTMethod act) ].
	"Assert/Then"
	aFamixUTMethod assertions do: [ :assertion | 
		statements addStatement: (self exportAssertion: assertion) ].
	^ method
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportSetUp: aFamixUTSetUp [

	self shouldBeImplemented
]

{ #category : #accessing }
FamixUTJUnitExporter >> model [

	^ model ifNil: [ model := FASTJavaModel new ]
]

{ #category : #exporting }
FamixUTJUnitExporter >> valueExporter [

	^ valueExporter ifNil: [ 
		  valueExporter := FamixValue2FASTJavaVisitor new model: self model ]
]
