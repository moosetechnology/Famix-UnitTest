"
Verifies that the behavior or feature being tested behaves as expected.
"
Class {
	#name : #FamixUTAssertion,
	#superclass : #FamixUTEntity,
	#instVars : [
		'#errorMargin => FMProperty',
		'#method => FMOne type: #FamixUTMethod opposite: #assertions'
	],
	#category : #'Famix-UnitTest-Entities-Entities'
}

{ #category : #meta }
FamixUTAssertion class >> annotation [

	<FMClass: #Assertion super: #FamixUTEntity>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	^ self
]

{ #category : #accessing }
FamixUTAssertion >> errorMargin [

	<FMProperty: #errorMargin type: #Object>
	<generated>
	<FMComment: 'How much deviation is allowed between the expected and actual values.'>
	^ errorMargin
]

{ #category : #accessing }
FamixUTAssertion >> errorMargin: anObject [
	<generated>
	errorMargin := anObject
]

{ #category : #accessing }
FamixUTAssertion >> expected [
	"Relation named: #expected type: #FamixValueOfType opposite: #expectedInAssertions"

	<generated>
	<container>
	<FMProperty: #expected type: #FamixValueOfType opposite: #expectedInAssertions>
	^ self attributeAt: #expected ifAbsent: [ nil ]
]

{ #category : #accessing }
FamixUTAssertion >> expected: anObject [

	<generated>
	self attributeAt: #expected put: (FMMultivalueLink on: self update: #expectedInAssertions from: self expected to: anObject).
]

{ #category : #navigation }
FamixUTAssertion >> expectedGroup [
	<generated>
	<navigation: 'Expected'>
	^ MooseSpecializedGroup with: self expected
]

{ #category : #accessing }
FamixUTAssertion >> method [
	"Relation named: #method type: #FamixUTMethod opposite: #assertions"

	<generated>
	<container>
	^ method
]

{ #category : #accessing }
FamixUTAssertion >> method: anObject [

	<generated>
	method := anObject
]

{ #category : #navigation }
FamixUTAssertion >> methodGroup [
	<generated>
	<navigation: 'Method'>
	^ MooseSpecializedGroup with: self method
]
