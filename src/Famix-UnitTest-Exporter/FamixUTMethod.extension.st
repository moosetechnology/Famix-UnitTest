Extension { #name : 'FamixUTMethod' }

{ #category : '*Famix-UnitTest-Exporter' }
FamixUTMethod >> allTypesOn: aCollection [

	act ifNotNil: [ act allTypesOn: aCollection ].
	assertions do: [ :assertion | assertion allTypesOn: aCollection ]
]
