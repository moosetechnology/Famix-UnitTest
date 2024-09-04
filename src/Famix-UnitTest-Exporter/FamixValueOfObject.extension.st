Extension { #name : 'FamixValueOfObject' }

{ #category : '*Famix-UnitTest-Exporter' }
FamixValueOfObject >> allTypesOn: aCollection seen: seen [

	(super allTypesOn: aCollection seen: seen) ifNotNil: [
		value do: [ :attribute |
			attribute value allTypesOn: aCollection seen: seen ] ]
]
