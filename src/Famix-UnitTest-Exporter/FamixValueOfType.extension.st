Extension { #name : #FamixValueOfType }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueOfType >> allTypes [

	| types |
	self
		allTypesOn: (types := OrderedCollection new)
		seen: IdentitySet new.
	^ types
]

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueOfType >> allTypesOn: aCollection [

	self allTypesOn: aCollection seen: IdentitySet new
]

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueOfType >> allTypesOn: aCollection seen: seen [

	(seen includes: self) ifTrue: [ ^ nil ].
	seen add: self.
	self type allTypesOn: aCollection.
	self typedEntity ifNotNil: [ :typedEntity |
		typedEntity declaredType allTypesOn: aCollection ]
]
