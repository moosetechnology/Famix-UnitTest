Extension { #name : #FamixJavaType }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixJavaType >> needsJavaImport [

	^ typeContainer mooseName ~= 'java::lang'
]
