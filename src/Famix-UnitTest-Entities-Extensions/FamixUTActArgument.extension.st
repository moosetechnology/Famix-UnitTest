Extension { #name : 'FamixUTActArgument' }

{ #category : '*Famix-UnitTest-Entities-Extensions' }
FamixUTActArgument >> mooseNameOn: aStream [

	aStream nextPutAll: 'Argument'.
	self value ifNotNil: [ :value |
		aStream nextPut: $(.
		value mooseNameOn: aStream.
		aStream nextPut: $) ].
	act ifNotNil: [
		aStream nextPutAll: ' of '.
		act mooseNameOn: aStream ]
]
