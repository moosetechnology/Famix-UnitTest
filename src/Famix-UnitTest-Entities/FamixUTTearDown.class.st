"
Tears down the system to make tests repeatable.

## Relations
======================

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `forAllInCase` | `FamixUTTearDown` | `afterAll` | `FamixUTCase` | |
| `forEachInCase` | `FamixUTTearDown` | `afterEach` | `FamixUTCase` | |
| `method` | `FamixUTTearDown` | `tearDown` | `FamixUTMethod` | |
| `suite` | `FamixUTTearDown` | `tearDown` | `FamixUTSuite` | |



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
	<derived>
	^ forAllInCase
]

{ #category : #accessing }
FamixUTTearDown >> forAllInCase: anObject [

	<generated>
	forAllInCase := anObject
]

{ #category : #accessing }
FamixUTTearDown >> forEachInCase [
	"Relation named: #forEachInCase type: #FamixUTCase opposite: #afterEach"

	<generated>
	<derived>
	^ forEachInCase
]

{ #category : #accessing }
FamixUTTearDown >> forEachInCase: anObject [

	<generated>
	forEachInCase := anObject
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
