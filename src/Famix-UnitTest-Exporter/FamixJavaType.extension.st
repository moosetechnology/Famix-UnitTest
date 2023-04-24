Extension { #name : #FamixJavaType }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixJavaType >> asFASTJavaTypeExpressionOn: aFASTJavaModel [

	^ aFASTJavaModel newClassTypeExpression typeName:
		  (aFASTJavaModel newTypeName name: name)
]
