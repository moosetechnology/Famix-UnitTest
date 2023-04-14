"
Object used in testing to replace a real object with a simplified version.
"
Class {
	#name : #FamixUTDouble,
	#superclass : #FamixUTEntity,
	#instVars : [
		'#expectedInAssertions => FMMany type: #FamixUTAssertion opposite: #expected',
		'#fixtures => FMMany type: #FamixUTFixture opposite: #doubles'
	],
	#category : #'Famix-UnitTest-Entities-Entities'
}

{ #category : #meta }
FamixUTDouble class >> annotation [

	<FMClass: #Double super: #FamixUTEntity>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	^ self
]

{ #category : #adding }
FamixUTDouble >> addExpectedInAssertion: anObject [
	<generated>
	^ self expectedInAssertions add: anObject
]

{ #category : #adding }
FamixUTDouble >> addFixture: anObject [
	<generated>
	^ self fixtures add: anObject
]

{ #category : #accessing }
FamixUTDouble >> expectedInAssertions [
	"Relation named: #expectedInAssertions type: #FamixUTAssertion opposite: #expected"

	<generated>
	<derived>
	^ expectedInAssertions
]

{ #category : #accessing }
FamixUTDouble >> expectedInAssertions: anObject [

	<generated>
	expectedInAssertions value: anObject
]

{ #category : #accessing }
FamixUTDouble >> fixtures [
	"Relation named: #fixtures type: #FamixUTFixture opposite: #doubles"

	<generated>
	^ fixtures
]

{ #category : #accessing }
FamixUTDouble >> fixtures: anObject [

	<generated>
	fixtures value: anObject
]
