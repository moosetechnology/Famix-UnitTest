Extension { #name : 'FamixUTTearDown' }

{ #category : '*Famix-UnitTest-Entities-Extensions' }
FamixUTTearDown >> mooseNameOn: aStream [

	aStream nextPutAll: 'TearDown'.
	super mooseNameOn: aStream
]
