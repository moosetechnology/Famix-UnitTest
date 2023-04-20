"
Sets up the system to make tests repeatable.
"
Class {
	#name : #FamixUTSetUp,
	#superclass : #FamixUTFixture,
	#instVars : [
		'#suite => FMOne type: #FamixUTSuite opposite: #setUp',
		'#beforeAllInCase => FMOne type: #FamixUTCase opposite: #beforeAll',
		'#beforeEachInCase => FMOne type: #FamixUTCase opposite: #beforeEach',
		'#method => FMOne type: #FamixUTMethod opposite: #setUp'
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
FamixUTSetUp >> beforeAllInCase [
	"Relation named: #beforeAllInCase type: #FamixUTCase opposite: #beforeAll"

	<generated>
	<derived>
	^ beforeAllInCase
]

{ #category : #accessing }
FamixUTSetUp >> beforeAllInCase: anObject [

	<generated>
	beforeAllInCase := anObject
]

{ #category : #accessing }
FamixUTSetUp >> beforeEachInCase [
	"Relation named: #beforeEachInCase type: #FamixUTCase opposite: #beforeEach"

	<generated>
	<derived>
	^ beforeEachInCase
]

{ #category : #accessing }
FamixUTSetUp >> beforeEachInCase: anObject [

	<generated>
	beforeEachInCase := anObject
]

{ #category : #accessing }
FamixUTSetUp >> method [
	"Relation named: #method type: #FamixUTMethod opposite: #setUp"

	<generated>
	<derived>
	^ method
]

{ #category : #accessing }
FamixUTSetUp >> method: anObject [

	<generated>
	method := anObject
]

{ #category : #accessing }
FamixUTSetUp >> suite [
	"Relation named: #suite type: #FamixUTSuite opposite: #setUp"

	<generated>
	<derived>
	^ suite
]

{ #category : #accessing }
FamixUTSetUp >> suite: anObject [

	<generated>
	suite := anObject
]
