Extension { #name : 'FamixTType' }

{ #category : '*Famix-UnitTest-Entities-accessing' }
FamixTType >> testCase [
	"Relation named: #testCase type: #FamixUTCase opposite: #testedClass"

	<generated>
	<derived>
	<FMProperty: #testCase type: #FamixUTCase opposite: #testedClass>
	<package: #'Famix-UnitTest-Entities'>
	^ self attributeAt: #testCase ifAbsent: [ nil ]
]

{ #category : '*Famix-UnitTest-Entities-accessing' }
FamixTType >> testCase: anObject [

	<generated>
	(self attributeAt: #testCase ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self testCase.
		self attributeAt: #testCase put: anObject.
		otherSide testedClass: nil ]
	ifNotNil: [ 
		self attributeAt: #testCase put: anObject.
		anObject testedClass: self ]
]
