Extension { #name : 'FamixUTAct' }

{ #category : '*Famix-UnitTest-Exporter' }
FamixUTAct >> allTypesOn: aCollection [

	self arguments do: [ :argument |
		argument value allTypesOn: aCollection ]
]
