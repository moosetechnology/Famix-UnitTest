Extension { #name : #FamixTParametricEntity }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixTParametricEntity >> allTypesOn: aCollection [

	aCollection add: self rootGenericEntity.
	aCollection addAll: self concreteParameters
]
