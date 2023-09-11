"
A collection of test cases.
"
Class {
	#name : #FamixUTSuite,
	#superclass : #FamixUTEntity,
	#traits : 'FamixTNamedEntity',
	#classTraits : 'FamixTNamedEntity classTrait',
	#instVars : [
		'#cases => FMMany type: #FamixUTCase opposite: #suite',
		'#setUp => FMOne type: #FamixUTSetUp opposite: #suite',
		'#tearDown => FMOne type: #FamixUTTearDown opposite: #suite'
	],
	#category : #'Famix-UnitTest-Entities-Entities'
}

{ #category : #meta }
FamixUTSuite class >> annotation [

	<FMClass: #Suite super: #FamixUTEntity>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	^ self
]

{ #category : #adding }
FamixUTSuite >> addCase: anObject [
	<generated>
	^ self cases add: anObject
]

{ #category : #accessing }
FamixUTSuite >> cases [
	"Relation named: #cases type: #FamixUTCase opposite: #suite"

	<generated>
	<derived>
	^ cases
]

{ #category : #accessing }
FamixUTSuite >> cases: anObject [

	<generated>
	cases value: anObject
]

{ #category : #navigation }
FamixUTSuite >> casesGroup [
	<generated>
	<navigation: 'Cases'>
	^ MooseSpecializedGroup withAll: self cases asSet
]

{ #category : #accessing }
FamixUTSuite >> setUp [
	"Relation named: #setUp type: #FamixUTSetUp opposite: #suite"

	<generated>
	^ setUp
]

{ #category : #accessing }
FamixUTSuite >> setUp: anObject [

	<generated>
	setUp := anObject
]

{ #category : #navigation }
FamixUTSuite >> setUpGroup [
	<generated>
	<navigation: 'SetUp'>
	^ MooseSpecializedGroup with: self setUp
]

{ #category : #accessing }
FamixUTSuite >> tearDown [
	"Relation named: #tearDown type: #FamixUTTearDown opposite: #suite"

	<generated>
	^ tearDown
]

{ #category : #accessing }
FamixUTSuite >> tearDown: anObject [

	<generated>
	tearDown := anObject
]

{ #category : #navigation }
FamixUTSuite >> tearDownGroup [
	<generated>
	<navigation: 'TearDown'>
	^ MooseSpecializedGroup with: self tearDown
]
