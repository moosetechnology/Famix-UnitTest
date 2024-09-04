Extension { #name : 'FamixValueOfDictionary' }

{ #category : '*Famix-UnitTest-Exporter' }
FamixValueOfDictionary >> allTypesOn: aCollection seen: seen [

	(super allTypesOn: aCollection seen: seen) ifNotNil: [
		value do: [ :assoc |
			assoc key allTypesOn: aCollection seen: seen.
			assoc value allTypesOn: aCollection seen: seen ] ]
]
