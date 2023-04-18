"
A class containing test methods.
"
Class {
	#name : #FamixUTCase,
	#superclass : #FamixUTEntity,
	#instVars : [
		'#methods => FMMany type: #FamixUTMethod opposite: #case',
		'#setUp => FMOne type: #FamixUTSetUp opposite: #case',
		'#suite => FMOne type: #FamixUTSuite opposite: #cases',
		'#tearDown => FMOne type: #FamixUTTearDown opposite: #case'
	],
	#category : #'Famix-UnitTest-Entities-Entities'
}

{ #category : #meta }
FamixUTCase class >> annotation [

	<FMClass: #Case super: #FamixUTEntity>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	^ self
]

{ #category : #adding }
FamixUTCase >> addMethod: anObject [
	<generated>
	^ self methods add: anObject
]

{ #category : #accessing }
FamixUTCase >> methods [
	"Relation named: #methods type: #FamixUTMethod opposite: #case"

	<generated>
	<derived>
	^ methods
]

{ #category : #accessing }
FamixUTCase >> methods: anObject [

	<generated>
	methods value: anObject
]

{ #category : #navigation }
FamixUTCase >> methodsGroup [
	<generated>
	<navigation: 'Methods'>
	^ MooseSpecializedGroup withAll: self methods asSet
]

{ #category : #accessing }
FamixUTCase >> setUp [
	"Relation named: #setUp type: #FamixUTSetUp opposite: #case"

	<generated>
	^ setUp
]

{ #category : #accessing }
FamixUTCase >> setUp: anObject [

	<generated>
	setUp := anObject
]

{ #category : #accessing }
FamixUTCase >> suite [
	"Relation named: #suite type: #FamixUTSuite opposite: #cases"

	<generated>
	<container>
	^ suite
]

{ #category : #accessing }
FamixUTCase >> suite: anObject [

	<generated>
	suite := anObject
]

{ #category : #navigation }
FamixUTCase >> suiteGroup [
	<generated>
	<navigation: 'Suite'>
	^ MooseSpecializedGroup with: self suite
]

{ #category : #accessing }
FamixUTCase >> tearDown [
	"Relation named: #tearDown type: #FamixUTTearDown opposite: #case"

	<generated>
	^ tearDown
]

{ #category : #accessing }
FamixUTCase >> tearDown: anObject [

	<generated>
	tearDown := anObject
]

{ #category : #accessing }
FamixUTCase >> testedClass [
	"Relation named: #testedClass type: #FamixTClass opposite: #testCase"

	<generated>
	<FMProperty: #testedClass type: #FamixTClass opposite: #testCase>
	^ self attributeAt: #testedClass ifAbsent: [ nil ]
]

{ #category : #accessing }
FamixUTCase >> testedClass: anObject [

	<generated>
	(self attributeAt: #testedClass ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self testedClass.
		self attributeAt: #testedClass put: anObject.
		otherSide testCase: nil ]
	ifNotNil: [ 
		self attributeAt: #testedClass put: anObject.
		anObject testCase: self ]
]
