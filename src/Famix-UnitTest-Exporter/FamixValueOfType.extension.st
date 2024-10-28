Extension { #name : 'FamixValueOfType' }

{ #category : '*Famix-UnitTest-Exporter' }
FamixValueOfType >> allTypes [

	| types |
	self
		allTypesOn: (types := OrderedCollection new)
		seen: IdentitySet new.
	^ types
]

{ #category : '*Famix-UnitTest-Exporter' }
FamixValueOfType >> allTypesOn: aCollection [

	self allTypesOn: aCollection seen: IdentitySet new
]

{ #category : '*Famix-UnitTest-Exporter' }
FamixValueOfType >> allTypesOn: aCollection seen: seen [

	(seen includes: self) ifTrue: [ ^ nil ].
	seen add: self.
	self type allTypesOn: aCollection.
	self typedEntity ifNotNil: [ :typedEntity |
		typedEntity declaredType ifNotNil: [ :declaredType | "This should not happen but it does!!!!!!!!!!!!!!!!!!"
			declaredType allTypesOn: aCollection ] ]
]

{ #category : '*Famix-UnitTest-Exporter' }
FamixValueOfType >> roleName [

	self argumentInSpans ifNotEmpty: [
		^ String streamContents: [ :s |
			  self typedEntity ifNotNil: [ :typedEntity |
				  s << typedEntity name << $_ ].
			  s << 'argument' ] ].
	self receiverInSpan ifNotNil: [ ^ 'receiver' ].
	self resultInSpan ifNotNil: [ ^ 'expected' ].
	Error signal: 'No role for this value'
]
