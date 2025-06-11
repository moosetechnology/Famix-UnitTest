Extension { #name : 'FamixUTMethod' }

{ #category : '*Famix-UnitTest-Entities-Extensions' }
FamixUTMethod >> fullyQualifiedName [

	^ String streamContents: [ :s |
		  self testedMethod parentType typeContainer fullyQualifiedName
			  ifNotEmpty: [ :containerName | s << containerName << '.' ].
		  s << self case name << '.' << self name ]
]

{ #category : '*Famix-UnitTest-Entities-Extensions' }
FamixUTMethod >> name [

	^ name ifNil: [
		  self testedMethod ifNil: [ super name ] ifNotNil: [ :method |
			  name := 'test' , (method name
				           ifNotNil: [ :methodName | methodName capitalized ]
				           ifNil: [ '<unnamed>' ]) ] ]
]

{ #category : '*Famix-UnitTest-Entities-Extensions' }
FamixUTMethod >> printOn: stream [

	case ifNotNil: [
		stream nextPutAll: case name.
		stream nextPut: $. ].
	stream nextPutAll: self name
]
