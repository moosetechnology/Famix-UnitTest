Extension { #name : #FamixValueOfType }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueOfType >> allTypesOn: aCollection [

	self allTypesOn: aCollection visited: Set new
]

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueOfType >> allTypesOn: aCollection visited: visited [

	(visited includes: self) ifTrue: [ ^ self ].
	visited add: self.
	self type allTypesOn: aCollection
]
