Extension { #name : #FamixValueOfCollection }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueOfCollection >> allTypesOn: aCollection seen: seen [

	(super allTypesOn: aCollection seen: seen) ifNotNil: [
		value do: [ :element |
			element value allTypesOn: aCollection seen: seen ] ]
]
