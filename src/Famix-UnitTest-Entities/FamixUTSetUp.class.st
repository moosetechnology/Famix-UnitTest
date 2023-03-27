"
Sets up the system to make tests repeatable.
"
Class {
	#name : #FamixUTSetUp,
	#superclass : #FamixUTFixture,
	#instVars : [
		'#suite => FMOne type: #FamixUTSuite opposite: #setUp',
		'#case => FMOne type: #FamixUTCase opposite: #setUp',
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
FamixUTSetUp >> case [
	"Relation named: #case type: #FamixUTCase opposite: #setUp"

	<generated>
	<derived>
	^ case
]

{ #category : #accessing }
FamixUTSetUp >> case: anObject [

	<generated>
	case := anObject
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
