Extension { #name : #FamixValueOfObject }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueOfObject >> allTypesOn: aCollection visited: visited [

	(super allTypesOn: aCollection visited: visited) ifNil: [ ^ nil ].
	value do: [ :attribute | 
		attribute value allTypesOn: aCollection visited: visited ]
]
