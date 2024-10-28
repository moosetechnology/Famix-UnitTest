"
Sets up the system to make tests repeatable.

## Relations
======================

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `forAllInCase` | `FamixUTSetUp` | `beforeAll` | `FamixUTCase` | |
| `forEachInCase` | `FamixUTSetUp` | `beforeEach` | `FamixUTCase` | |
| `method` | `FamixUTSetUp` | `setUp` | `FamixUTMethod` | |
| `suite` | `FamixUTSetUp` | `setUp` | `FamixUTSuite` | |



"
Class {
	#name : 'FamixUTSetUp',
	#superclass : 'FamixUTFixture',
	#instVars : [
		'#forAllInCase => FMOne type: #FamixUTCase opposite: #beforeAll',
		'#forEachInCase => FMOne type: #FamixUTCase opposite: #beforeEach',
		'#method => FMOne type: #FamixUTMethod opposite: #setUp',
		'#suite => FMOne type: #FamixUTSuite opposite: #setUp'
	],
	#category : 'Famix-UnitTest-Entities-Entities',
	#package : 'Famix-UnitTest-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FamixUTSetUp class >> annotation [

	<FMClass: #SetUp super: #FamixUTFixture>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FamixUTSetUp >> forAllInCase [
	"Relation named: #forAllInCase type: #FamixUTCase opposite: #beforeAll"

	<generated>
	<derived>
	^ forAllInCase
]

{ #category : 'accessing' }
FamixUTSetUp >> forAllInCase: anObject [

	<generated>
	forAllInCase := anObject
]

{ #category : 'accessing' }
FamixUTSetUp >> forEachInCase [
	"Relation named: #forEachInCase type: #FamixUTCase opposite: #beforeEach"

	<generated>
	<derived>
	^ forEachInCase
]

{ #category : 'accessing' }
FamixUTSetUp >> forEachInCase: anObject [

	<generated>
	forEachInCase := anObject
]

{ #category : 'accessing' }
FamixUTSetUp >> method [
	"Relation named: #method type: #FamixUTMethod opposite: #setUp"

	<generated>
	<derived>
	^ method
]

{ #category : 'accessing' }
FamixUTSetUp >> method: anObject [

	<generated>
	method := anObject
]

{ #category : 'accessing' }
FamixUTSetUp >> suite [
	"Relation named: #suite type: #FamixUTSuite opposite: #setUp"

	<generated>
	<derived>
	^ suite
]

{ #category : 'accessing' }
FamixUTSetUp >> suite: anObject [

	<generated>
	suite := anObject
]
