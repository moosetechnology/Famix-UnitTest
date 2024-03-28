Extension { #name : #FamixUTFixture }

{ #category : #'*Famix-UnitTest-Entities-Extensions' }
FamixUTFixture >> forAllInCase [

	self subclassResponsibility
]

{ #category : #'*Famix-UnitTest-Entities-Extensions' }
FamixUTFixture >> forEachInCase [

	self subclassResponsibility
]

{ #category : #'*Famix-UnitTest-Entities-Extensions' }
FamixUTFixture >> method [

	self subclassResponsibility
]

{ #category : #'*Famix-UnitTest-Entities-Extensions' }
FamixUTFixture >> mooseNameOn: aStream [

	self suite ifNotNil: [ :suite |
		aStream nextPutAll: ' of '.
		^ suite mooseNameOn: aStream ].
	self forAllInCase ifNotNil: [ :case |
		aStream nextPutAll: ' of all methods in '.
		^ case mooseNameOn: aStream ].
	self forEachInCase ifNotNil: [ :case |
		aStream nextPutAll: ' of each method in '.
		^ case mooseNameOn: aStream ].
	self method ifNotNil: [ :method |
		aStream nextPutAll: ' of '.
		method mooseNameOn: aStream ]
]

{ #category : #'*Famix-UnitTest-Entities-Extensions' }
FamixUTFixture >> suite [

	self subclassResponsibility
]
