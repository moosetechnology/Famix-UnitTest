"
Tears down the system to make tests repeatable.
"
Class {
	#name : #FamixUTTearDown,
	#superclass : #FamixUTFixture,
	#instVars : [
		'#forAllInCase => FMOne type: #FamixUTCase opposite: #afterAll',
		'#forEachInCase => FMOne type: #FamixUTCase opposite: #afterEach',
		'#method => FMOne type: #FamixUTMethod opposite: #tearDown',
		'#suite => FMOne type: #FamixUTSuite opposite: #tearDown'
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
FamixUTTearDown >> forAllInCase [
	"Relation named: #forAllInCase type: #FamixUTCase opposite: #afterAll"

	<generated>
	<container>
	<derived>
	^ forAllInCase
]

{ #category : #accessing }
FamixUTTearDown >> forAllInCase: anObject [

	<generated>
	forAllInCase := anObject
]

{ #category : #navigation }
FamixUTTearDown >> forAllInCaseGroup [
	<generated>
	<navigation: 'ForAllInCase'>
	^ MooseSpecializedGroup with: self forAllInCase
]

{ #category : #accessing }
FamixUTTearDown >> forEachInCase [
	"Relation named: #forEachInCase type: #FamixUTCase opposite: #afterEach"

	<generated>
	<container>
	<derived>
	^ forEachInCase
]

{ #category : #accessing }
FamixUTTearDown >> forEachInCase: anObject [

	<generated>
	forEachInCase := anObject
]

{ #category : #navigation }
FamixUTTearDown >> forEachInCaseGroup [
	<generated>
	<navigation: 'ForEachInCase'>
	^ MooseSpecializedGroup with: self forEachInCase
]

{ #category : #accessing }
FamixUTTearDown >> method [
	"Relation named: #method type: #FamixUTMethod opposite: #tearDown"

	<generated>
	<container>
	<derived>
	^ method
]

{ #category : #accessing }
FamixUTTearDown >> method: anObject [

	<generated>
	method := anObject
]

{ #category : #navigation }
FamixUTTearDown >> methodGroup [
	<generated>
	<navigation: 'Method'>
	^ MooseSpecializedGroup with: self method
]

{ #category : #accessing }
FamixUTTearDown >> suite [
	"Relation named: #suite type: #FamixUTSuite opposite: #tearDown"

	<generated>
	<container>
	<derived>
	^ suite
]

{ #category : #accessing }
FamixUTTearDown >> suite: anObject [

	<generated>
	suite := anObject
]

{ #category : #navigation }
FamixUTTearDown >> suiteGroup [
	<generated>
	<navigation: 'Suite'>
	^ MooseSpecializedGroup with: self suite
]
