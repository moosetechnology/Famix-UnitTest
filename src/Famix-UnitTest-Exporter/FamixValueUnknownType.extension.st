Extension { #name : #FamixValueUnknownType }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueUnknownType >> mooseNameWithDots [

	^ name
]

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueUnknownType >> needsJavaImport [

	^ self name ~= 'Object'
]
