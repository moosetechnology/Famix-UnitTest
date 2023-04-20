Extension { #name : #FamixValueOfType }

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixValueOfType >> argumentInActs [
	"Relation named: #argumentInActs type: #FamixUTAct opposite: #arguments"

	<generated>
	<FMProperty: #argumentInActs type: #FamixUTAct opposite: #arguments>
	<package: #'Famix-UnitTest-Entities'>
	^ self attributeAt: #argumentInActs ifAbsentPut: [ FMMultiMultivalueLink on: self opposite: #arguments ]
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
	"Relation named: #fixtures type: #FamixUTFixture opposite: #doubles"

	<generated>
	<FMProperty: #fixtures type: #FamixUTFixture opposite: #doubles>
	<package: #'Famix-UnitTest-Entities'>
	^ self attributeAt: #fixtures ifAbsentPut: [ FMMultiMultivalueLink on: self opposite: #doubles ]
]

{ #category : #'*Famix-UnitTest-Entities-accessing' }
FamixValueOfType >> fixtures: anObject [

	<generated>
	self fixtures value: anObject
]
