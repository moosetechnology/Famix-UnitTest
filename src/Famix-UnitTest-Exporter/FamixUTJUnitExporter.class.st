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

	| testedMethod invocation |
	testedMethod := aFamixUTAct method testedMethod.
	invocation := self model newMethodInvocation
		              name: testedMethod name;
		              receiver: (model newNewExpression type:
					               (testedMethod parentType
						                asFASTJavaTypeExpressionOn: self valueExporter));
		              arguments:
			              (aFamixUTAct arguments collect: [ :argument |
					               self valueExporter makeVariableExpression:
							               argument ]);
		              famixMethod: testedMethod.
	^ self statements addStatement:
		  (testedMethod declaredType name = 'void'
			   ifTrue: [ model newExpressionStatement expression: invocation ]
			   ifFalse: [
				   model newVarDeclStatement
					   type: (testedMethod declaredType asFASTJavaTypeExpressionOn:
								    self valueExporter);
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
				    addArgument:
					    (self valueExporter makeVariableExpression:
							     aFamixUTAssertion expected);
				    addArgument: (model newVariableExpression name: 'actual');
				    yourself))
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportCase: aFamixUTCase [

	^ self model newClassDeclaration
		  name: aFamixUTCase name;
		  addModifier: (model newModifier token: 'public');
		  declarations:
			  (aFamixUTCase methods collect: [ :method |
					   self exportMethod: method ])
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportCaseFile: aFamixUTCase [

	^ self model newCompilationUnit
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
FamixUTJUnitExporter >> makeTestMethod: aFamixUTMethod [

	^ self model newMethodEntity
		  name: aFamixUTMethod name , valueExporter nextId asString; "TODO better name"
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

	self statements: self model newStatementBlock.
	^ statements
]

{ #category : #accessing }
FamixUTJUnitExporter >> newValueExporter [

	^ FamixValue2FASTJavaVisitor new
]
