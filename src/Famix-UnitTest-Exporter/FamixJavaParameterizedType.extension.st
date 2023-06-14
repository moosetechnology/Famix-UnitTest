Extension { #name : #FamixJavaParameterizedType }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixJavaParameterizedType >> allTypesOn: aCollection [

	aCollection add: self parameterizableClass.
	arguments do: [ :argument | argument allTypesOn: aCollection ]
]
