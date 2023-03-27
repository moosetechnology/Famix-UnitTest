"
Tears down the system to make tests repeatable.
"
Class {
	#name : #FamixUTTearDown,
	#superclass : #FamixUTFixture,
	#instVars : [
		'#suite => FMOne type: #FamixUTSuite opposite: #tearDown',
		'#case => FMOne type: #FamixUTCase opposite: #tearDown',
		'#method => FMOne type: #FamixUTMethod opposite: #tearDown'
	],
	#category : #'Famix-UnitTest-Entities-Entities'
}

{ #category : #meta }
FamixUTTearDown class >> annotation [

	<FMClass: #TearDown super: #FamixUTFixture>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	^ self
]

{ #category : #accessing }
FamixUTTearDown >> case [
	"Relation named: #case type: #FamixUTCase opposite: #tearDown"

	<generated>
	<derived>
	^ case
]

{ #category : #accessing }
FamixUTTearDown >> case: anObject [

	<generated>
	case := anObject
]

{ #category : #accessing }
FamixUTTearDown >> method [
	"Relation named: #method type: #FamixUTMethod opposite: #tearDown"

	<generated>
	<derived>
	^ method
]

{ #category : #accessing }
FamixUTTearDown >> method: anObject [

	<generated>
	method := anObject
]

{ #category : #accessing }
FamixUTTearDown >> suite [
	"Relation named: #suite type: #FamixUTSuite opposite: #tearDown"

	<generated>
	<derived>
	^ suite
]

{ #category : #accessing }
FamixUTTearDown >> suite: anObject [

	<generated>
	suite := anObject
]
