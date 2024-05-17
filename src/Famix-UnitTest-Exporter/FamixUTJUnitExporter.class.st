Class {
	#name : #FamixUTJUnitExporter,
	#superclass : #FamixUTAbstractExporter,
	#instVars : [
		'currentCompilationUnit',
		'currentClass',
		'constructorDict'
	],
	#category : #'Famix-UnitTest-Exporter-Exporters'
}

{ #category : #testing }
FamixUTJUnitExporter class >> isAbstract [

	^ self == FamixUTJUnitExporter
]

{ #category : #exporting }
FamixUTJUnitExporter >> assertionStrategy [

	^ assertionStrategy ifNil: [
		  assertionStrategy := FamixUTAbstractJavaAssertionStrategy default ]
]

{ #category : #accessing }
FamixUTJUnitExporter >> assertionStrategy: aFamixUTAssertionStrategy [

	assertionStrategy := aFamixUTAssertionStrategy
]

{ #category : #exporting }
FamixUTJUnitExporter >> constructorDict [

	^ constructorDict ifNil: [ constructorDict := IdentityDictionary new ]
]

{ #category : #accessing }
FamixUTJUnitExporter >> currentClass [

	^ currentClass
]

{ #category : #'accessing - properties' }
FamixUTJUnitExporter >> currentClassHasAutowiredProperty [
	"add as moose cached property"

	^ currentClass attributeAt: #hasAutowiredProperty ifAbsentPut: [
		  currentClass declarations anySatisfy: [ :declaration |
			  (declaration isKindOf: FASTJavaVarDeclStatement) and: [
				  declaration modifiers anySatisfy: [ :modifier |
					  modifier name = 'Autowired' ] ] ] ]
]

{ #category : #accessing }
FamixUTJUnitExporter >> currentCompilationUnit [

	^ currentCompilationUnit
]

{ #category : #exporting }
FamixUTJUnitExporter >> enableReflectionFor: aFamixJavaAttribute [
	"Give access to the given attribute using reflection.
	An attribute of the test class will hold the Field object."

	| constructor fieldVarName |
	fieldVarName := aFamixJavaAttribute name , 'Field'.
	currentClass addDeclaration: (model newVarDeclStatement
			 type: (model newClassTypeExpression typeName:
						  (model newTypeName name: 'Field'));
			 addModifier: (model newModifier token: 'private');
			 addDeclarator: (model newVariableDeclarator variable:
						  (model newVariableExpression name: fieldVarName));
			 yourself).

	"Ensure a constructor exists for the test class"
	constructor := self ensureClassConstructorForReflection.

	"Get the Field using reflection and make it accessible"
	constructor statementBlock
		addStatement: (model newExpressionStatement expression:
					 (model newAssignmentExpression
						  variable: (model newVariableExpression name: fieldVarName);
						  operator: '=';
						  expression: (model newMethodInvocation
								   receiver: (model newClassProperty
										    type:
											    (model newIdentifier name:
													     aFamixJavaAttribute parentType name);
										    fieldName: 'class');
								   name: 'getDeclaredField';
								   addArgument:
								   (model newStringLiteral primitiveValue:
									    aFamixJavaAttribute name);
								   yourself)));
		addStatement:
			(model newExpressionStatement expression:
				 (model newMethodInvocation
					  receiver: (model newVariableExpression name: fieldVarName);
					  name: 'setAccessible';
					  addArgument: (model newBooleanLiteral primitiveValue: 'true');
					  yourself))
]

{ #category : #exporting }
FamixUTJUnitExporter >> ensureClassConstructorForReflection [
	"To enable attribute reflection in Java, we need to get the Field and make it accessible"

	^ self constructorDict
		  at: currentClass
		  ifAbsentPut: [ "add import for Field type"
			  currentCompilationUnit addImportDeclaration:
				  (model newImportDeclaration qualifiedName:
					   (model newQualifiedName name: 'java.lang.reflect.Field')).
			  "add constructor"
			  currentClass addDeclaration: (model newMethodEntity
					   name: currentClass name;
					   addModifier: (model newModifier token: 'public');
					   throws: {
							   (model newClassTypeExpression typeName:
									    (model newTypeName name: 'NoSuchFieldException')).
							   (model newClassTypeExpression typeName:
									    (model newTypeName name: 'SecurityException')) };
					   statementBlock: model newStatementBlock) ]
]

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
FamixUTJUnitExporter >> exportCase: aFamixUTCase [
	"Returns a public test class."

	(currentClass := self model newClassDeclaration)
		name: aFamixUTCase name;
		addModifier: (model newModifier token: 'public');
		addComment: self makeTestCaseComment;
		addDeclaration: (self makeTestCaseReceiver: aFamixUTCase).

	caseSuperclass ifNotNil: [ "inherit from configured superclass"
		currentClass superclass:
			(caseSuperclass asFASTJavaTypeExpressionOn: valueExporter) ].

	aFamixUTCase methods do: [ :method |
		currentClass addDeclaration: (self exportMethod: method) ].

	"Add 'autowire' method to add properties to the receiver."
	self currentClassHasAutowiredProperty ifTrue: [
		self makeTestCaseAutowire: aFamixUTCase ].

	"Suppress some warnings for now..."
	currentClass addModifier: (model newAnnotation
			 name: 'SuppressWarnings';
			 elements: { (model newArrayAnnotationElement values: {
							  (model newStringLiteral primitiveValue: 'rawtypes').
							  (model newStringLiteral primitiveValue: 'unchecked') }) }).

	^ currentClass
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportCaseCompilationUnit: aFamixUTCase [
	"Export imports after the class because new dependencies can be added during the process."

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
	imports := valueExporter builder makeImportDeclarations: aFamixUTCase.
	imports add:
		(valueExporter builder makeImportDeclaration:
			 aFamixUTCase testedClass).
	imports addAll: self makeJUnitImports.
	imports addAll: (self assertionStrategy dependencyImportsOn: self).
	^ imports
]

{ #category : #exporting }
FamixUTJUnitExporter >> exportCasePackage: aFamixUTCase [

	^ self model newPackageDeclaration qualifiedName:
		  (model newQualifiedName name:
			   aFamixUTCase testedClass typeContainer mooseNameWithDots)
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

	currentCompilationUnit := self model newCompilationUnit.
	currentClass := model newClassDeclaration name: aFamixUTSuite name.

	currentClass modifiers: {
			(model newAnnotation
				 name: 'RunWith';
				 elements: { (model newClassProperty
						  type: (model newIdentifier name: 'Suite');
						  fieldName: 'class') }).
			(model newAnnotation
				 name: 'SuiteClasses';
				 elements: { (model newArrayAnnotationElement values:
							  (aFamixUTSuite cases collect: [ :case |
									   model newClassProperty
										   type: (model newIdentifier name: case name);
										   fieldName: 'class' ])) }).
			(model newModifier token: 'public') }.

	currentCompilationUnit
		packageDeclaration: (model newPackageDeclaration qualifiedName:
					 (model newQualifiedName name: 'fr.evref.modest'));
		importDeclarations: {
				(model newImportDeclaration qualifiedName:
						 (model newQualifiedName name: 'org.junit.runner.RunWith')).
				(model newImportDeclaration qualifiedName:
						 (model newQualifiedName name: 'org.junit.runners.Suite')).
				(model newImportDeclaration qualifiedName:
						 (model newQualifiedName name:
								  'org.junit.runners.Suite.SuiteClasses')) }
			, (aFamixUTSuite cases collect: [ :case |
						 model newImportDeclaration qualifiedName:
								 (model newQualifiedName name:
										  case testedClass typeContainer mooseNameWithDots , '.'
										  , case name) ]);
		addClassDeclaration: currentClass.
	^ currentCompilationUnit
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
		  (model newImportDeclaration qualifiedName:
			   (model newQualifiedName name:
				    package , '.' , self nameOfBeforeEachAnnotation)) }
]

{ #category : #exporting }
FamixUTJUnitExporter >> makeTestCaseAutowire: aFamixUTCase [
	"UseCases are not autowireable, but the services are. To really test the UseCase methods,
	we autowire the services and inject them into the instance with a setter in a setup method."

	| testedClass ucName autowireMethod usesReflection |
	testedClass := aFamixUTCase testedClass.
	ucName := testedClass name uncapitalized.
	autowireMethod := model newMethodEntity.
	usesReflection := false.
	autowireMethod
		name: 'autowire';
		type: model newVoidTypeExpression;
		modifiers: {
				(model newAnnotation name: 'Before').
				(model newModifier token: 'public') };
		statementBlock:
			(model newStatementBlock statements: (currentClass declarations
						  select: [ :declaration |
							  (declaration isKindOf: FASTJavaVarDeclStatement) and: [
									  declaration declarators first variable name ~= ucName ] ]
						  thenCollect: [ :declaration |
							  | serviceName attribute |
							  serviceName := declaration declarators first variable name.
							  attribute := testedClass attributes detect: [ :a |
									               a name = serviceName ].
							  (testedClass findSetterOf: attribute)
								  ifNotNil: [ :setter | "use setter: uc.setService(service);"
									  model newExpressionStatement expression:
											  (model newMethodInvocation
												   receiver: (model newVariableExpression name: ucName);
												   name: setter name;
												   addArgument:
													   (model newVariableExpression name: serviceName);
												   famixMethod: setter) ]
								  ifNil: [ "use reflection"
									  usesReflection ifFalse: [
										  usesReflection := true.
										  autowireMethod throws: {
												  (model newClassTypeExpression typeName:
													   (model newTypeName name: 'IllegalArgumentException')).
												  (model newClassTypeExpression typeName:
													   (model newTypeName name: 'IllegalAccessException')) } ].
									  self enableReflectionFor: attribute.
									  model newExpressionStatement expression:
										  (model newMethodInvocation
											   receiver:
												   (model newVariableExpression name:
														    serviceName , 'Field');
											   name: 'set';
											   addArgument: (model newVariableExpression name: ucName);
											   addArgument:
												   (model newVariableExpression name: serviceName);
											   yourself) ] ])).
	currentClass declarations:
		{ autowireMethod } , currentClass declarations
]

{ #category : #ast }
FamixUTJUnitExporter >> makeTestCaseComment [
	"Javadoc saying the tests are generated by Modest and when."

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

	| method |
	method := (super makeTestMethod: aFamixUTMethod)
		          addModifier: (model newAnnotation name: 'Test');
		          addModifier: (model newModifier token: 'public');
		          type: model newVoidTypeExpression;
		          statementBlock: self newStatementBlock.
	"Throw the same exceptions as the tested method"
	aFamixUTMethod testedMethod declaredExceptions do: [ :exception |
		method addThrow:
			(exception asFASTJavaTypeExpressionOn: self valueExporter).
		currentCompilationUnit addImportDeclaration:
			(valueExporter builder makeImportDeclaration: exception) ].
	^ method
]

{ #category : #naming }
FamixUTJUnitExporter >> nameOfAssertionsClass [

	self subclassResponsibility
]

{ #category : #naming }
FamixUTJUnitExporter >> nameOfBeforeEachAnnotation [

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
