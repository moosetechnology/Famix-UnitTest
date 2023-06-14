Extension { #name : #FamixValueOfDictionary }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueOfDictionary >> allTypesOn: aCollection visited: visited [

	(visited includes: self) ifTrue: [ ^ self ].
	visited add: self.
	self type allTypesOn: aCollection.
	value do: [ :assoc | 
		assoc key allTypesOn: aCollection visited: visited.
		assoc value allTypesOn: aCollection visited: visited ]
]
