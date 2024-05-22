Extension { #name : #FamixValueOfType }

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixValueOfType >> argumentInAct [
	"Relation named: #argumentInAct type: #FamixUTAct opposite: #arguments"

	<generated>
	<FMProperty: #argumentInAct type: #FamixUTAct opposite: #arguments>
	<package: #'Famix-UnitTest-Entities'>
	^ self attributeAt: #argumentInAct ifAbsent: [ nil ]
]

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixValueOfType >> argumentInAct: anObject [

	<generated>
	self attributeAt: #argumentInAct put: (FMMultivalueLink on: self update: #arguments from: self argumentInAct to: anObject).
]

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixValueOfType >> argumentInActs [
	"Relation named: #argumentInActs type: #FamixUTActArgument opposite: #value"

	<generated>
	<derived>
	<FMProperty: #argumentInActs type: #FamixUTActArgument opposite: #value>
	<package: #'Famix-UnitTest-Entities'>
	^ self attributeAt: #argumentInActs ifAbsentPut: [ FMMultivalueLink on: self opposite: #value: ]
]

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixValueOfType >> argumentInActs: anObject [

	<generated>
	self argumentInActs value: anObject
]

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixValueOfType >> expectedInAssertions [
	"Relation named: #expectedInAssertions type: #FamixUTAssertion opposite: #expected"

	<generated>
	<derived>
	<FMProperty: #expectedInAssertions type: #FamixUTAssertion opposite: #expected>
	<package: #'Famix-UnitTest-Entities'>
	^ self attributeAt: #expectedInAssertions ifAbsentPut: [ FMMultivalueLink on: self opposite: #expected: ]
]

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixValueOfType >> expectedInAssertions: anObject [

	<generated>
	self expectedInAssertions value: anObject
]

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixValueOfType >> fixtures [
	"Relation named: #fixtures type: #FamixUTFixture opposite: #values"

	<generated>
	<FMProperty: #fixtures type: #FamixUTFixture opposite: #values>
	<package: #'Famix-UnitTest-Entities'>
	^ self attributeAt: #fixtures ifAbsentPut: [ FMMultiMultivalueLink on: self opposite: #values ]
]

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixValueOfType >> fixtures: anObject [

	<generated>
	self fixtures value: anObject
]

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixValueOfType >> receiverInAct [
	"Relation named: #receiverInAct type: #FamixUTAct opposite: #receiver"

	<generated>
	<derived>
	<FMProperty: #receiverInAct type: #FamixUTAct opposite: #receiver>
	<package: #'Famix-UnitTest-Entities'>
	^ self attributeAt: #receiverInAct ifAbsent: [ nil ]
]

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixValueOfType >> receiverInAct: anObject [

	<generated>
	(self attributeAt: #receiverInAct ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self receiverInAct.
		self attributeAt: #receiverInAct put: anObject.
		otherSide receiver: nil ]
	ifNotNil: [ 
		self attributeAt: #receiverInAct put: anObject.
		anObject receiver: self ]
]
