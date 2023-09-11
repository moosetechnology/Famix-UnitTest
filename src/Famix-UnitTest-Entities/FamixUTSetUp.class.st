"
Sets up the system to make tests repeatable.
"
Class {
	#name : #FamixUTSetUp,
	#superclass : #FamixUTFixture,
	#instVars : [
		'#forAllInCase => FMOne type: #FamixUTCase opposite: #beforeAll',
		'#forEachInCase => FMOne type: #FamixUTCase opposite: #beforeEach',
		'#method => FMOne type: #FamixUTMethod opposite: #setUp',
		'#suite => FMOne type: #FamixUTSuite opposite: #setUp'
	],
	#category : #'Famix-UnitTest-Entities-Entities'
}

{ #category : #meta }
FamixUTSetUp class >> annotation [

	<FMClass: #SetUp super: #FamixUTFixture>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	^ self
]

{ #category : #accessing }
FamixUTSetUp >> forAllInCase [
	"Relation named: #forAllInCase type: #FamixUTCase opposite: #beforeAll"

	<generated>
	<container>
	<derived>
	^ forAllInCase
]

{ #category : #accessing }
FamixUTSetUp >> forAllInCase: anObject [

	<generated>
	forAllInCase := anObject
]

{ #category : #navigation }
FamixUTSetUp >> forAllInCaseGroup [
	<generated>
	<navigation: 'ForAllInCase'>
	^ MooseSpecializedGroup with: self forAllInCase
]

{ #category : #accessing }
FamixUTSetUp >> forEachInCase [
	"Relation named: #forEachInCase type: #FamixUTCase opposite: #beforeEach"

	<generated>
	<container>
	<derived>
	^ forEachInCase
]

{ #category : #accessing }
FamixUTSetUp >> forEachInCase: anObject [

	<generated>
	forEachInCase := anObject
]

{ #category : #navigation }
FamixUTSetUp >> forEachInCaseGroup [
	<generated>
	<navigation: 'ForEachInCase'>
	^ MooseSpecializedGroup with: self forEachInCase
]

{ #category : #accessing }
FamixUTSetUp >> method [
	"Relation named: #method type: #FamixUTMethod opposite: #setUp"

	<generated>
	<container>
	<derived>
	^ method
]

{ #category : #accessing }
FamixUTSetUp >> method: anObject [

	<generated>
	method := anObject
]

{ #category : #navigation }
FamixUTSetUp >> methodGroup [
	<generated>
	<navigation: 'Method'>
	^ MooseSpecializedGroup with: self method
]

{ #category : #accessing }
FamixUTSetUp >> suite [
	"Relation named: #suite type: #FamixUTSuite opposite: #setUp"

	<generated>
	<container>
	<derived>
	^ suite
]

{ #category : #accessing }
FamixUTSetUp >> suite: anObject [

	<generated>
	suite := anObject
]

{ #category : #navigation }
FamixUTSetUp >> suiteGroup [
	<generated>
	<navigation: 'Suite'>
	^ MooseSpecializedGroup with: self suite
]
