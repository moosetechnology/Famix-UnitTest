Extension { #name : #FamixUTAct }

{ #category : #'*Famix-UnitTest-Entities-Extensions' }
FamixUTAct >> mooseNameOn: aStream [

	aStream nextPutAll: 'Act'.
	method ifNotNil: [
		aStream nextPutAll: ' in '.
		method mooseNameOn: aStream ]
]
