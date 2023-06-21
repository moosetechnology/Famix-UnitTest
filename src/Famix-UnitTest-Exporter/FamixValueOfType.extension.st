Extension { #name : #FamixValueOfType }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueOfType >> allTypesOn: aCollection [

	self allTypesOn: aCollection visited: Set new
]

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueOfType >> allTypesOn: aCollection visited: visited [

	(visited includes: self) ifTrue: [ ^ nil ].
	visited add: self.
	self type allTypesOn: aCollection.
	self typedEntity ifNotNil: [ :typedEntity | 
		typedEntity declaredType allTypesOn: aCollection ]
]
