Extension { #name : #FamixUTMethod }

{ #category : #'*Famix-UnitTest-Entities-Extensions' }
FamixUTMethod >> name [

	^ name ifNil: [
		  self testedMethod ifNil: [ super name ] ifNotNil: [ :method |
			  name := 'test' , (method name
				           ifNotNil: [ :methodName | methodName capitalized ]
				           ifNil: [ '<unnamed>' ]) ] ]
]
