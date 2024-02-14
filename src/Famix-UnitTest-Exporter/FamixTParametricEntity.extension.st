Extension { #name : #FamixTParametricEntity }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixTParametricEntity >> allTypesOn: aCollection [

	aCollection add: self genericEntity.
	aCollection addAll: self concreteParameters
]
