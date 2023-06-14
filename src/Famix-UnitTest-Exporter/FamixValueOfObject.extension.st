Extension { #name : #FamixValueOfObject }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueOfObject >> allTypesOn: aCollection visited: visited [

	(visited includes: self) ifTrue: [ ^ self ].
	visited add: self.
	self type allTypesOn: aCollection.
	value do: [ :attribute | 
		attribute value allTypesOn: aCollection visited: visited ]
]
