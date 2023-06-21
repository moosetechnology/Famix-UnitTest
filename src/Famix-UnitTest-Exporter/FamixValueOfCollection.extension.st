Extension { #name : #FamixValueOfCollection }

{ #category : #'*Famix-UnitTest-Exporter' }
FamixValueOfCollection >> allTypesOn: aCollection visited: visited [

	(super allTypesOn: aCollection visited: visited) ifNil: [ ^ nil ].
	value do: [ :element | 
		element value allTypesOn: aCollection visited: visited ]
]
