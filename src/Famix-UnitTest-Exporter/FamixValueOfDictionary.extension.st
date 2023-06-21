Extension { #name : #FamixValueOfDictionary }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueOfDictionary >> allTypesOn: aCollection visited: visited [

	(super allTypesOn: aCollection visited: visited) ifNil: [ ^ nil ].
	value do: [ :assoc | 
		assoc key allTypesOn: aCollection visited: visited.
		assoc value allTypesOn: aCollection visited: visited ]
]
