"
A collection of test cases.
"
Class {
	#name : #FamixUTSuite,
	#superclass : #FamixUTEntity,
	#instVars : [
		'#cases => FMMany type: #FamixUTCase opposite: #suite',
		'#setUp => FMOne type: #FamixUTFixture opposite: #setUpInSuite',
		'#tearDown => FMOne type: #FamixUTFixture opposite: #tearDownInSuite'
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
	"Relation named: #setUp type: #FamixUTFixture opposite: #setUpInSuite"

	<generated>
	^ setUp
]

{ #category : #accessing }
FamixUTSuite >> setUp: anObject [

	<generated>
	setUp := anObject
]

{ #category : #accessing }
FamixUTSuite >> tearDown [
	"Relation named: #tearDown type: #FamixUTFixture opposite: #tearDownInSuite"

	<generated>
	^ tearDown
]

{ #category : #accessing }
FamixUTSuite >> tearDown: anObject [

	<generated>
	tearDown := anObject
]
