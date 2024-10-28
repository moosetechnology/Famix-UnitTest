Extension { #name : 'FamixTMethod' }

{ #category : '*Famix-UnitTest-Entities-accessing' }
FamixTMethod >> unitTests [
	"Relation named: #unitTests type: #FamixUTMethod opposite: #testedMethod"

	<generated>
	<derived>
	<FMProperty: #unitTests type: #FamixUTMethod opposite: #testedMethod>
	<package: #'Famix-UnitTest-Entities'>
	^ self attributeAt: #unitTests ifAbsentPut: [ FMMultivalueLink on: self opposite: #testedMethod: ]
]

{ #category : '*Famix-UnitTest-Entities-accessing' }
FamixTMethod >> unitTests: anObject [

	<generated>
	self unitTests value: anObject
]
