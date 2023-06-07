Extension { #name : #FamixUTSetUp }

{ #category : #'*Famix-UnitTest-Entities-Extensions' }
FamixUTSetUp >> mooseNameOn: aStream [

	aStream nextPutAll: 'SetUp'.
	super mooseNameOn: aStream
]
