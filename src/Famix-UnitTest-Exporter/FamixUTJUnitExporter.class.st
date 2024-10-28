Class {
	#name : 'FamixUTJUnitExporter',
	#superclass : 'FamixUTAbstractExporter',
	#instVars : [
		'currentCompilationUnit',
		'constructorDict'
	],
	#category : 'Famix-UnitTest-Exporter-Exporters',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Exporters'
}

{ #category : 'testing' }
FamixUTJUnitExporter class >> isAbstract [

	^ self == FamixUTJUnitExporter
]

{ #category : 'exporting' }
FamixUTJUnitExporter >> assertionStrategy [

	^ assertionStrategy ifNil: [
		  assertionStrategy := FamixUTAbstractJavaAssertionStrategy default ]
]

{ #category : 'accessing' }
FamixUTJUnitExporter >> assertionStrategy: aFamixUTAssertionStrategy [

	assertionStrategy := aFamixUTAssertionStrategy
]

{ #category : 'exporting' }
FamixUTJUnitExporter >> constructorDict [

	^ constructorDict ifNil: [ constructorDict := IdentityDictionary new ]
]

{ #category : 'accessing - properties' }
FamixUTJUnitExporter >> currentClassHasAutowiredProperty [

	^ currentClass declarations anySatisfy: [ :declaration |
		  (declaration isKindOf: FASTJavaVarDeclStatement) and: [
			  declaration modifiers anySatisfy: [ :modifier |
				  modifier name = 'Autowired' ] ] ]
]

{ #category : 'accessing' }
FamixUTJUnitExporter >> currentCompilationUnit [

	^ currentCompilationUnit
]

{ #category : 'exporting' }
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

{ #category : 'exporting' }
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

{ #category : 'exporting' }
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

{ #category : 'exporting' }
FamixUTJUnitExporter >> exportCase: aFamixUTCase [
	"Returns a public test class."

	(currentClass := self model newClassDeclaration)
		name: aFamixUTCase name;
		addModifier: (model newModifier token: 'public');
		addComment: self makeTestCaseComment.

	caseSuperclass ifNotNil: [ "inherit from configured superclass"
		currentClass superclass:
			(caseSuperclass asFASTJavaTypeExpressionOn: valueExporter) ].

	aFamixUTCase methods do: [ :method |
		[ currentClass addDeclaration: (self exportMethod: method) ]
			on: Error
			do: [ :e | "propose to skip methods with errors"
				FamixUTSkipWarning signalFor: method because: e ] ].

	"Stop here if no methods were successfully exported"
	currentClass declarations ifEmpty: [ ^ nil ].

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

{ #category : 'exporting' }
FamixUTJUnitExporter >> exportCaseCompilationUnit: aFamixUTCase [

	currentCompilationUnit := self model newCompilationUnit.
	currentCompilationUnit
		packageDeclaration: (self exportCasePackage: aFamixUTCase);
		importDeclarations: (self exportCaseImports: aFamixUTCase).
	(self exportCase: aFamixUTCase)
		ifNil: [ "all method exports failed"
		currentCompilationUnit removeFromModel ]
		ifNotNil: [ :case |
		currentCompilationUnit addClassDeclaration: case ]
]

{ #category : 'exporting' }
FamixUTJUnitExporter >> exportCaseImports: aFamixUTCase [

	| imports |
	(imports := valueExporter builder makeImportDeclarations:
			            aFamixUTCase)
		add:
			(valueExporter builder makeImportDeclaration:
					 aFamixUTCase testedClass);
		addAll: self makeJUnitImports;
		addAll: (self assertionStrategy dependencyImportsOn: self);
		addAll: (self methodSetUpStrategy dependencyImportsOn: self).

	caseSuperclass ifNotNil: [ "import configured superclass"
		imports add:
			(valueExporter builder makeImportDeclaration: caseSuperclass) ].

	"TODO: handle autowired import"
	"exportCaseImports: after exportCase: then add the autowired check"
	"self currentClassHasAutowiredProperty ifTrue: [
		imports add: (model newImportDeclaration qualifiedName:
				 (model newQualifiedName name:
					  'org.springframework.beans.factory.annotation.Autowired')) ]."
	^ imports
]

{ #category : 'exporting' }
FamixUTJUnitExporter >> exportCasePackage: aFamixUTCase [
	"Export the package declaration for the test class.
	The tested class can be an inner type, e.g. com.Example.Inner, so asLowercase is applied for a valid package name"

	^ self model newPackageDeclaration qualifiedName:
		  (model newQualifiedName name:
			   aFamixUTCase testedClass typeContainer mooseNameWithDots
				   asLowercase)
]

{ #category : 'exporting' }
FamixUTJUnitExporter >> exportMethodTearDown: aFamixUTTearDown [

	self shouldBeImplemented
]

{ #category : 'exporting' }
FamixUTJUnitExporter >> exportSetUp: aFamixUTSetUp [

	self shouldBeImplemented
]

{ #category : 'exporting' }
FamixUTJUnitExporter >> exportSuite: aFamixUTSuite [

	currentCompilationUnit := self model newCompilationUnit.
	currentClass := model newClassDeclaration name: aFamixUTSuite name.

	currentClass modifiers: (self makeSuiteAnnotations: aFamixUTSuite)
		, { (model newModifier token: 'public') }.

	currentCompilationUnit
		packageDeclaration: (model newPackageDeclaration qualifiedName:
					 (model newQualifiedName name: 'fr.evref.modest'));
		importDeclarations:
			self makeSuiteImports , (aFamixUTSuite cases collect: [ :case |
						 model newImportDeclaration qualifiedName:
								 (model newQualifiedName name:
										  case testedClass typeContainer mooseNameWithDots
											  asLowercase , '.' , case name) ]);
		addClassDeclaration: currentClass.
	^ currentCompilationUnit
]

{ #category : 'ast' }
FamixUTJUnitExporter >> makeActComment [

	^ self model newComment content: '/* ACT */'
]

{ #category : 'ast' }
FamixUTJUnitExporter >> makeActInvocation: aFamixUTAct [

	| testedMethod |
	testedMethod := aFamixUTAct method testedMethod.
	^ self model newMethodInvocation
		  receiver: (self makeActReceiver: aFamixUTAct);
		  name: testedMethod name;
		  arguments: (aFamixUTAct arguments collect: [ :argument |
					   self valueExporter makeVariableExpression: argument value ]);
		  famixMethod: testedMethod
]

{ #category : 'ast' }
FamixUTJUnitExporter >> makeActReceiver: aFamixUTAct [

	^ aFamixUTAct receiver
		  ifNotNil: [ :receiver |
			  model newVariableExpression name:
				  (valueExporter varNameFor: receiver) ]
		  ifNil: [ "I guess this is not a good place to initialize the receiver during the act
			TODO: initialize beforehand, and always use a variable reference to receive act."
			  model newNewExpression type:
				  (aFamixUTAct method testedMethod parentType
					   asFASTJavaTypeExpressionOn: self valueExporter) ]
]

{ #category : 'ast' }
FamixUTJUnitExporter >> makeActVarDecl: aFamixUTAct [

	^ self model newVarDeclStatement
		  type: (aFamixUTAct method testedMethod declaredType
				   asFASTJavaTypeExpressionOn: self valueExporter);
		  addDeclarator: (model newVariableDeclarator variable:
					   (model newVariableExpression name: 'actual'));
		  yourself
]

{ #category : 'ast' }
FamixUTJUnitExporter >> makeArrangeComment [

	^ self model newComment content: '/* ARRANGE */'
]

{ #category : 'ast' }
FamixUTJUnitExporter >> makeAssertComment [

	^ self model newComment content: '/* ASSERT */'
]

{ #category : 'ast' }
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

{ #category : 'exporting' }
FamixUTJUnitExporter >> makeSuiteAnnotations: aFamixUTSuite [
	"Return the class annotations to apply to a suite class"

	self subclassResponsibility
]

{ #category : 'exporting' }
FamixUTJUnitExporter >> makeSuiteImports [

	self subclassResponsibility
]

{ #category : 'exporting' }
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

{ #category : 'ast' }
FamixUTJUnitExporter >> makeTestCaseComment [
	"Javadoc saying the tests are generated by Modest and when."

	^ model newComment content:
		  '/**@author Generated by <a href="https://github.com/Evref-BL/Modest">Modest</a>'
		  , String lf , '@version ' , DateAndTime now asString , '*/'
]

{ #category : 'ast' }
FamixUTJUnitExporter >> makeTestCaseReceiver: aFamixUTCase [
	"The variable containing an instance of the tested class"

	| testedClass |
	Error signal: 'Do not use an attribute to store receiver'.
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

{ #category : 'ast' }
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

{ #category : 'naming' }
FamixUTJUnitExporter >> nameOfAssertionsClass [

	self subclassResponsibility
]

{ #category : 'naming' }
FamixUTJUnitExporter >> nameOfBeforeEachAnnotation [

	self subclassResponsibility
]

{ #category : 'naming' }
FamixUTJUnitExporter >> nameOfJUnitPackage [

	self subclassResponsibility
]

{ #category : 'instance creation' }
FamixUTJUnitExporter >> newStatementBlock [

	self statementBlock: self model newStatementBlock.
	^ statementBlock
]

{ #category : 'instance creation' }
FamixUTJUnitExporter >> newValueExporter [

	^ FamixValue2FASTJavaVisitor new
]
