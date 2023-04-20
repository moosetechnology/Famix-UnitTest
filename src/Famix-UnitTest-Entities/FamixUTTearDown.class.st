"
Tears down the system to make tests repeatable.
"
Class {
	#name : #FamixUTTearDown,
	#superclass : #FamixUTFixture,
	#instVars : [
		'#suite => FMOne type: #FamixUTSuite opposite: #tearDown',
		'#afterAllInCase => FMOne type: #FamixUTCase opposite: #afterAll',
		'#afterEachInCase => FMOne type: #FamixUTCase opposite: #afterEach',
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
FamixUTTearDown >> afterAllInCase [
	"Relation named: #afterAllInCase type: #FamixUTCase opposite: #afterAll"

	<generated>
	<derived>
	^ afterAllInCase
]

{ #category : #accessing }
FamixUTTearDown >> afterAllInCase: anObject [

	<generated>
	afterAllInCase := anObject
]

{ #category : #accessing }
FamixUTTearDown >> afterEachInCase [
	"Relation named: #afterEachInCase type: #FamixUTCase opposite: #afterEach"

	<generated>
	<derived>
	^ afterEachInCase
]

{ #category : #accessing }
FamixUTTearDown >> afterEachInCase: anObject [

	<generated>
	afterEachInCase := anObject
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
