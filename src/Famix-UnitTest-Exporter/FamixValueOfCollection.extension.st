Extension { #name : #FamixValueOfCollection }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueOfCollection >> allTypesOn: aCollection visited: visited [

	(visited includes: self) ifTrue: [ ^ self ].
	visited add: self.
	self type allTypesOn: aCollection.
	value do: [ :element | 
		element value allTypesOn: aCollection visited: visited ]
]
