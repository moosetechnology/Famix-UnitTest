Extension { #name : #FamixValueUnknownType }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueUnknownType >> mooseNameWithDots [

	^ name
]

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueUnknownType >> needsJavaImport [

	^ (name size = 6 or: [ 
		   name size = 16 and: [ name beginsWith: 'java.lang.' ] ]) and: [ 
		  name endsWith: 'Object' ]
]
