Extension { #name : 'FamixUTCase' }

{ #category : '*Famix-UnitTest-Entities-Extensions' }
FamixUTCase >> mooseNameOn: aStream [

	aStream nextPutAll: self name
]

{ #category : '*Famix-UnitTest-Entities-Extensions' }
FamixUTCase >> name [

	^ self testedClass name
		  ifNotNil: [ :name | name , 'Test' ]
		  ifNil: [ '<unnamed>Test' ]
]
