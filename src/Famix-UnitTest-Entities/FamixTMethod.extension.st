Extension { #name : #FamixTMethod }

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixTMethod >> unitTest [
	"Relation named: #unitTest type: #FamixUTMethod opposite: #testedMethod"

	<generated>
	<derived>
	<FMProperty: #unitTest type: #FamixUTMethod opposite: #testedMethod>
	<package: #'Famix-UnitTest-Entities'>
	^ self attributeAt: #unitTest ifAbsent: [ nil ]
]

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixTMethod >> unitTest: anObject [

	<generated>
	(self attributeAt: #unitTest ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self unitTest.
		self attributeAt: #unitTest put: anObject.
		otherSide testedMethod: nil ]
	ifNotNil: [ 
		self attributeAt: #unitTest put: anObject.
		anObject testedMethod: self ]
]
