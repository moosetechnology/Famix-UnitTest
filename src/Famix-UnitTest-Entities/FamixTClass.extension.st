Extension { #name : #FamixTClass }

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixTClass >> unitTest [
	"Relation named: #unitTest type: #FamixUTCase opposite: #testedClass"

	<generated>
	<derived>
	<FMProperty: #unitTest type: #FamixUTCase opposite: #testedClass>
	<package: #'Famix-UnitTest-Entities'>
	^ self attributeAt: #unitTest ifAbsent: [ nil ]
]

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixTClass >> unitTest: anObject [

	<generated>
	(self attributeAt: #unitTest ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self unitTest.
		self attributeAt: #unitTest put: anObject.
		otherSide testedClass: nil ]
	ifNotNil: [ 
		self attributeAt: #unitTest put: anObject.
		anObject testedClass: self ]
]
