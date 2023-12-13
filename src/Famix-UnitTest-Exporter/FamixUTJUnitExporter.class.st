Class {
	#name : #FamixUTJUnitExporter,
	#superclass : #FamixUTAbstractExporter,
	#instVars : [
		'currentCompilationUnit',
		'currentClass'
	],
	#category : #'Famix-UnitTest-Exporter'
}

{ #category : #exporting }
FamixUTJUnitExporter >> exportAct: aFamixUTAct [
	"Execute the method under test"

	| invocation |
	invocation := self makeActInvocation: aFamixUTAct.
	^ self statementBlock addStatement:
		  (aFamixUTAct method testedMethod isProcedure
			   ifTrue: [ model newExpressionStatement expression: invocation ]
			   ifFalse: [ "Store the result in the `actual` variable"
				   | varDecl |
				   varDecl := self makeActVarDecl: aFamixUTAct.
				   varDecl declarators first expression: invocation.
				   varDecl ])
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportAssertion: aFamixUTAssertion [

	| expected expectedType actual |
	expected := self valueExporter makeVariableExpression:
		            aFamixUTAssertion expected.
	expectedType := aFamixUTAssertion expected type.
	actual := self model newVariableExpression name: 'actual'.
	(expectedType isClass and: [ expectedType isPrimitiveWrapper ])
		ifTrue: [
			expected := model newCastExpression
				            type:
					            (expectedType asFASTJavaTypeExpressionOn:
							             self valueExporter);
				            expression: expected ].
	^ self statementBlock addStatement:
		  (self model newExpressionStatement expression:
			   (model newMethodInvocation
				    name: 'assertEquals';
				    addArgument: expected;
				    addArgument: actual;
				    yourself))
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportCase: aFamixUTCase [

	currentClass := self model newClassDeclaration.
	currentClass
		name: aFamixUTCase name;
		addModifier: (model newModifier token: 'public');
		addComment: self makeTestCaseComment;
		addDeclaration: (self makeTestCaseReceiver: aFamixUTCase).
	aFamixUTCase methods do: [ :method |
		currentClass addDeclaration: (self exportMethod: method) ].
	^ currentClass
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportCaseFile: aFamixUTCase [

	currentCompilationUnit := self model newCompilationUnit.
	^ currentCompilationUnit
		  packageDeclaration: (self exportCasePackage: aFamixUTCase);
		  importDeclarations: (self exportCaseImports: aFamixUTCase);
		  addClassDeclaration: (self exportCase: aFamixUTCase);
		  yourself
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportCaseImports: aFamixUTCase [

	| imports |
	imports := (aFamixUTCase allTypes select: #needsJavaImport)
		           collect: [ :type | self makeImportDeclaration: type ]
		           as: OrderedCollection.
	imports add: (self makeImportDeclaration: aFamixUTCase testedClass).
	imports addAll: self makeJUnitImports.
	^ imports
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportCasePackage: aFamixUTCase [

	^ self model newPackageDeclaration qualifiedName:
		  (model newQualifiedName name:
			   aFamixUTCase testedClass typeContainer mooseNameWithDots)
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportMethodSetUp: aFamixUTSetUp [

	aFamixUTSetUp values do: [ :value | value accept: self valueExporter ]
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportMethodTearDown: aFamixUTTearDown [

	self shouldBeImplemented
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportSetUp: aFamixUTSetUp [

	self shouldBeImplemented
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportSuite: aFamixUTSuite [

	self shouldBeImplemented
]

{ #category : #ast }
FamixUTJUnitExporter >> makeActComment [

	^ self model newComment content: '/* ACT */'
]

{ #category : #ast }
FamixUTJUnitExporter >> makeActInvocation: aFamixUTAct [

	| testedMethod |
	testedMethod := aFamixUTAct method testedMethod.
	^ self model newMethodInvocation
		  receiver: (self makeActReceiver: testedMethod);
		  name: testedMethod name;
		  arguments: (aFamixUTAct arguments collect: [ :argument |
					   self valueExporter makeVariableExpression: argument ]);
		  famixMethod: testedMethod
]

{ #category : #ast }
FamixUTJUnitExporter >> makeActReceiver: testedMethod [

	^ model newNewExpression type:
		  (testedMethod parentType asFASTJavaTypeExpressionOn:
			   self valueExporter)
]

{ #category : #ast }
FamixUTJUnitExporter >> makeActVarDecl: aFamixUTAct [

	^ self model newVarDeclStatement
		  type: (aFamixUTAct method testedMethod declaredType
				   asFASTJavaTypeExpressionOn: self valueExporter);
		  addDeclarator: (model newVariableDeclarator variable:
					   (model newVariableExpression name: 'actual'));
		  yourself
]

{ #category : #ast }
FamixUTJUnitExporter >> makeArrangeComment [

	^ self model newComment content: '/* ARRANGE */'
]

{ #category : #ast }
FamixUTJUnitExporter >> makeAssertComment [

	^ self model newComment content: '/* ASSERT */'
]

{ #category : #ast }
FamixUTJUnitExporter >> makeJUnitImports [

	| package |
	package := self nameOfJUnitPackage.
	^ {
		  (self model newImportDeclaration qualifiedName:
			   (model newQualifiedName name: package , '.Test')).
		  (self model newImportDeclaration
			   qualifiedName: (model newQualifiedName name:
						    package , '.' , self nameOfAssertionsClass);
			   isStatic: true;
			   isOnDemand: true) }
]

{ #category : #ast }
FamixUTJUnitExporter >> makeTestCaseComment [
	"JavaDoc saying the tests are generated by Modest and when"

	^ model newComment content:
		  '/**@author Generated by <a href="https://github.com/Evref-BL/Modest">Modest</a>'
		  , String lf , '@version ' , DateAndTime now asString , '*/'
]

{ #category : #ast }
FamixUTJUnitExporter >> makeTestCaseReceiver: aFamixUTCase [
	"The variable containing an instance of the tested class"

	| testedClass |
	testedClass := aFamixUTCase testedClass.
	^ self model newVarDeclStatement
		  type: (testedClass asFASTJavaTypeExpressionOn: self valueExporter);
		  addModifier: (model newModifier token: 'private');
		  addDeclarator: (model newVariableDeclarator
				   variable:
					   (model newVariableExpression name:
							    testedClass name uncapitalized);
				   expression: (model newNewExpression type:
							    (aFamixUTCase testedClass asFASTJavaTypeExpressionOn:
									     self valueExporter)));
		  yourself
]

{ #category : #ast }
FamixUTJUnitExporter >> makeTestMethod: aFamixUTMethod [

	^ self model newMethodEntity
		  name: aFamixUTMethod name ", valueExporter nextId asString"; "TODO better name"
		  addModifier: (model newAnnotation name: 'Test');
		  addModifier: (model newModifier token: 'public');
		  type: model newVoidTypeExpression;
		  statementBlock: self newStatementBlock
]

{ #category : #naming }
FamixUTJUnitExporter >> nameOfAssertionsClass [

	self subclassResponsibility
]

{ #category : #naming }
FamixUTJUnitExporter >> nameOfJUnitPackage [

	self subclassResponsibility
]

{ #category : #'instance creation' }
FamixUTJUnitExporter >> newStatementBlock [

	self statementBlock: self model newStatementBlock.
	^ statementBlock
]

{ #category : #'instance creation' }
FamixUTJUnitExporter >> newValueExporter [

	^ FamixValue2FASTJavaVisitor new
]
