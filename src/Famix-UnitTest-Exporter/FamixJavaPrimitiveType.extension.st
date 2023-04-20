Extension { #name : #FamixJavaPrimitiveType }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixJavaPrimitiveType >> asFASTJavaTypeExpressionOn: aFASTJavaModel [

	name = 'boolean' ifTrue: [ ^ aFASTJavaModel newBooleanTypeExpression ].
	name = 'byte' ifTrue: [ ^ aFASTJavaModel newByteTypeExpression ].
	name = 'char' ifTrue: [ ^ aFASTJavaModel newCharTypeExpression ].
	name = 'double' ifTrue: [ ^ aFASTJavaModel newDoubleTypeExpression ].
	name = 'float' ifTrue: [ ^ aFASTJavaModel newFloatTypeExpression ].
	name = 'int' ifTrue: [ ^ aFASTJavaModel newIntTypeExpression ].
	name = 'long' ifTrue: [ ^ aFASTJavaModel newLongTypeExpression ].
	name = 'short' ifTrue: [ ^ aFASTJavaModel newShortTypeExpression ].
	self error: 'Unknown primitive type'
]
