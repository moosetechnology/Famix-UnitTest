"
Tests a specific behavior or feature of the system under test.
"
Class {
	#name : #FamixUTMethod,
	#superclass : #FamixUTEntity,
	#instVars : [
		'#assertions => FMMany type: #FamixUTAssertion opposite: #method',
		'#case => FMOne type: #FamixUTCase opposite: #methods',
		'#name => FMProperty',
		'#setUp => FMOne type: #FamixUTSetUp opposite: #method',
		'#tearDown => FMOne type: #FamixUTTearDown opposite: #method'
	],
	#category : #'Famix-UnitTest-Entities-Entities'
}

{ #category : #meta }
FamixUTMethod class >> annotation [

	<FMClass: #Method super: #FamixUTEntity>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	^ self
]

{ #category : #adding }
FamixUTMethod >> addAssertion: anObject [
	<generated>
	^ self assertions add: anObject
]

{ #category : #accessing }
FamixUTMethod >> assertions [
	"Relation named: #assertions type: #FamixUTAssertion opposite: #method"

	<generated>
	<derived>
	^ assertions
]

{ #category : #accessing }
FamixUTMethod >> assertions: anObject [

	<generated>
	assertions value: anObject
]

{ #category : #navigation }
FamixUTMethod >> assertionsGroup [
	<generated>
	<navigation: 'Assertions'>
	^ MooseSpecializedGroup withAll: self assertions asSet
]

{ #category : #accessing }
FamixUTMethod >> case [
	"Relation named: #case type: #FamixUTCase opposite: #methods"

	<generated>
	<container>
	^ case
]

{ #category : #accessing }
FamixUTMethod >> case: anObject [

	<generated>
	case := anObject
]

{ #category : #navigation }
FamixUTMethod >> caseGroup [
	<generated>
	<navigation: 'Case'>
	^ MooseSpecializedGroup with: self case
]

{ #category : #accessing }
FamixUTMethod >> name [

	<FMProperty: #name type: #String>
	<generated>
	^ name
]

{ #category : #accessing }
FamixUTMethod >> name: anObject [
	<generated>
	name := anObject
]

{ #category : #accessing }
FamixUTMethod >> setUp [
	"Relation named: #setUp type: #FamixUTSetUp opposite: #method"

	<generated>
	^ setUp
]

{ #category : #accessing }
FamixUTMethod >> setUp: anObject [

	<generated>
	setUp := anObject
]

{ #category : #accessing }
FamixUTMethod >> tearDown [
	"Relation named: #tearDown type: #FamixUTTearDown opposite: #method"

	<generated>
	^ tearDown
]

{ #category : #accessing }
FamixUTMethod >> tearDown: anObject [

	<generated>
	tearDown := anObject
]

{ #category : #accessing }
FamixUTMethod >> testedMethod [
	"Relation named: #testedMethod type: #FamixTMethod opposite: #unitTest"

	<generated>
	<FMProperty: #testedMethod type: #FamixTMethod opposite: #unitTest>
	^ self attributeAt: #testedMethod ifAbsent: [ nil ]
]

{ #category : #accessing }
FamixUTMethod >> testedMethod: anObject [

	<generated>
	(self attributeAt: #testedMethod ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self testedMethod.
		self attributeAt: #testedMethod put: anObject.
		otherSide unitTest: nil ]
	ifNotNil: [ 
		self attributeAt: #testedMethod put: anObject.
		anObject unitTest: self ]
]
