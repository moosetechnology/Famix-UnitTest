Extension { #name : #FamixJavaClass }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixJavaClass >> isPrimitiveWrapper [

	^ #( Integer Float Double Long Short Byte ) includes: name
]
