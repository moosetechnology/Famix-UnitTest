"
Sets up or tears down the system to make tests repeatable.

## Relations
======================

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `values` | `FamixUTFixture` | `fixtures` | `FamixValueOfType` | |



"
Class {
	#name : 'FamixUTFixture',
	#superclass : 'FamixUTEntity',
	#category : 'Famix-UnitTest-Entities-Entities',
	#package : 'Famix-UnitTest-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FamixUTFixture class >> annotation [

	<FMClass: #Fixture super: #FamixUTEntity>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	<abstract>
	^ self
]

{ #category : 'testing' }
FamixUTFixture class >> isAbstract [

	<generated>
	^ self == FamixUTFixture
]

{ #category : 'adding' }
FamixUTFixture >> addValue: anObject [
	<generated>
	^ self values add: anObject
]

{ #category : 'accessing' }
FamixUTFixture >> values [
	"Relation named: #values type: #FamixValueOfType opposite: #fixtures"

	<generated>
	<derived>
	<FMProperty: #values type: #FamixValueOfType opposite: #fixtures>
	^ self attributeAt: #values ifAbsentPut: [ FMMultiMultivalueLink on: self opposite: #fixtures ]
]

{ #category : 'accessing' }
FamixUTFixture >> values: anObject [

	<generated>
	self values value: anObject
]
