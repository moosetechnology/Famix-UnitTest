Extension { #name : 'FamixUTCase' }

{ #category : '*Famix-UnitTest-Exporter' }
FamixUTCase >> allTypes [

	| types |
	self allTypesOn: (types := Set new).
	^ types
]

{ #category : '*Famix-UnitTest-Exporter' }
FamixUTCase >> allTypesOn: aCollection [

	beforeAll ifNotNil: [ beforeAll allTypesOn: aCollection ].
	afterAll ifNotNil: [ afterAll allTypesOn: aCollection ].
	beforeEach ifNotNil: [ beforeEach allTypesOn: aCollection ].
	afterEach ifNotNil: [ afterEach allTypesOn: aCollection ].
	methods do: [ :method | method allTypesOn: aCollection ]
]
