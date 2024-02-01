"
A collection of test cases.

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `cases` | `FamixUTSuite` | `suite` | `FamixUTCase` | |

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `setUp` | `FamixUTSuite` | `suite` | `FamixUTSetUp` | |
| `tearDown` | `FamixUTSuite` | `suite` | `FamixUTTearDown` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `name` | `String` | nil | Basic name of the entity, not full reference.|

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
