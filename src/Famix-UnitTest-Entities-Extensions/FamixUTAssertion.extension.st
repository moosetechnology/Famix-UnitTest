Extension { #name : 'FamixUTAssertion' }

{ #category : '*Famix-UnitTest-Entities-Extensions' }
FamixUTAssertion >> mooseNameOn: aStream [

	aStream nextPutAll: 'Assertion'.
	method ifNotNil: [
		aStream nextPutAll: ' in '.
		method mooseNameOn: aStream ]
]
