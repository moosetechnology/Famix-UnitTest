Extension { #name : 'FamixUTCase' }

{ #category : '*Famix-UnitTest-Entities-Extensions' }
FamixUTCase >> fullyQualifiedName [

	^ String streamContents: [ :s |
		  self testedClass typeContainer fullyQualifiedName ifNotEmpty: [
			  :containerName | s << containerName << '.' ].
		  s << self name ]
]

{ #category : '*Famix-UnitTest-Entities-Extensions' }
FamixUTCase >> mooseNameOn: aStream [

	aStream nextPutAll: self name
]

{ #category : '*Famix-UnitTest-Entities-Extensions' }
FamixUTCase >> name [

	^ self attributeAt: #name ifAbsentPut: [
		  self testedClass name
			  ifNotNil: [ :name | name , 'Test' ]
			  ifNil: [ '<unnamed>Test' ] ]
]

{ #category : '*Famix-UnitTest-Entities-Extensions' }
FamixUTCase >> name: aString [

	self attributeAt: #name put: aString
]

{ #category : '*Famix-UnitTest-Entities-Extensions' }
FamixUTCase >> printOn: stream [

	stream nextPutAll: self name
]
