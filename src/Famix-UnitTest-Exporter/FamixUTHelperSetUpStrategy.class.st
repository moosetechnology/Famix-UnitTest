"
I export Arrange elements as methods in an external helper class.
"
Class {
	#name : #FamixUTHelperSetUpStrategy,
	#superclass : #FamixUTAbstractSetUpStrategy,
	#category : #'Famix-UnitTest-Exporter-Strategies'
}

{ #category : #ast }
FamixUTHelperSetUpStrategy >> ensureHelperClassOn: aFamixUTExporter [
	"Get or create the helper class for the exporter's current class."

	| model className |
	model := aFamixUTExporter model.
	className := aFamixUTExporter currentClass name , 'Helper'.
	^ model allFASTJavaClassDeclaration
		  detect: [ :class | class name = className ]
		  ifNone: [ "add import for the helper class and create it"
			  aFamixUTExporter currentCompilationUnit addImportDeclaration:
				  (model newImportDeclaration
					   qualifiedName:
						   (model newQualifiedName name: ((WriteStream with:
										      aFamixUTExporter currentCompilationUnit
											      packageDeclaration qualifiedName name) << '.'
								     << className) contents);
					   isStatic: true;
					   isOnDemand: true).
			  self makeHelperClassNamed: className on: aFamixUTExporter ]
]

{ #category : #exporting }
FamixUTHelperSetUpStrategy >> export: aFamixUTSetUp on: aFamixUTExporter [

	| model valueExporter helperClass comment |
	aFamixUTSetUp values ifEmpty: [ ^ self ].
	model := aFamixUTExporter model.
	valueExporter := aFamixUTExporter valueExporter.
	comment := '/**{@link ' , aFamixUTSetUp method case name , '#'
	           , aFamixUTSetUp method name , '()}*/'.
	"Only make helper if necessary => at least one non-empty object, collection or dictionary."
	aFamixUTSetUp values do: [ :value |
		((value isOfObject or: [
			  value isOfCollection or: [ value isOfDictionary ] ]) and: [
			 value value isNotEmpty ])
			ifFalse: [ value accept: valueExporter ]
			ifTrue: [
				| methodName |
				methodName := ((WriteStream with: 'given_')
				               << value typedEntity name
				               <<
				               (value resultInSpan
					                ifNotNil: [ '_expected' ]
					                ifNil: [ '_argument' ]) << '_for_'
				               << aFamixUTSetUp method name) contents.
				helperClass ifNil: [
					helperClass := self ensureHelperClassOn: aFamixUTExporter ].
				helperClass addDeclaration:
					((self makeHelperMethodFor: value on: aFamixUTExporter)
						 name: methodName;
						 addComment: (model newComment content: comment);
						 yourself).
				"add necessary imports to the helper class"
				helperClass compilationUnit importDeclarations addAll:
					(valueExporter builder makeImportDeclarations: value).
				"IMPORTANT: build the method before calling it and assigning it to the variable,
				because a value is considered already exported if it has been named!"
				valueExporter statementBlock addStatement:
					(model newVarDeclStatement
						 type: (value asFASTJavaTypeExpressionOn: valueExporter);
						 addDeclarator: (model newVariableDeclarator
								  variable: (valueExporter makeVariableExpression: value);
								  expression: (model newMethodInvocation name: methodName));
						 yourself) ] ]
]

{ #category : #ast }
FamixUTHelperSetUpStrategy >> makeHelperClassNamed: className on: aFamixUTExporter [
	"Make a compilation unit containing the helper class and return the latter."

	| model |
	model := aFamixUTExporter model.
	^ model newCompilationUnit
		  packageDeclaration: (model newPackageDeclaration qualifiedName:
					   (model newQualifiedName name:
							    aFamixUTExporter currentCompilationUnit packageDeclaration
								    qualifiedName name));
		  importDeclarations:
			  (aFamixUTExporter valueExporter objectExportStrategy
				   dependencyImportsOn: model);
		  addClassDeclaration: (model newClassDeclaration name: className)
]

{ #category : #ast }
FamixUTHelperSetUpStrategy >> makeHelperMethodFor: value on: aFamixUTExporter [
	"Export the value inside the helper method, then restore the previous context."

	| model valueExporter method oldStatementBlock newStatementBlock |
	model := aFamixUTExporter model.
	valueExporter := aFamixUTExporter valueExporter.
	oldStatementBlock := valueExporter statementBlock.
	method := model newMethodEntity
		          addModifier: (model newModifier token: 'public');
		          addModifier: (model newModifier token: 'static');
		          type: (valueExporter builder referType: value type);
		          statementBlock:
			          (newStatementBlock := model newStatementBlock).
	value accept: (valueExporter statementBlock: newStatementBlock).
	newStatementBlock addStatement:
		(model newReturnStatement expression:
			 (valueExporter makeVariableExpression: value)).
	valueExporter statementBlock: oldStatementBlock.
	^ method
]
