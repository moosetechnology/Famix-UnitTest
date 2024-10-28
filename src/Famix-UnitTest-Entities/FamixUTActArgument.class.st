"
An association between an `Act` and a `Value` argument.

## Relations
======================

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `act` | `FamixUTActArgument` | `arguments` | `FamixUTAct` | |
| `value` | `FamixUTActArgument` | `argumentInActs` | `FamixValueOfType` | |



"
Class {
	#name : 'FamixUTActArgument',
	#superclass : 'FamixUTEntity',
	#instVars : [
		'#act => FMOne type: #FamixUTAct opposite: #arguments'
	],
	#category : 'Famix-UnitTest-Entities-Entities',
	#package : 'Famix-UnitTest-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FamixUTActArgument class >> annotation [

	<FMClass: #ActArgument super: #FamixUTEntity>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FamixUTActArgument >> act [
	"Relation named: #act type: #FamixUTAct opposite: #arguments"

	<generated>
	^ act
]

{ #category : 'accessing' }
FamixUTActArgument >> act: anObject [

	<generated>
	act := anObject
]

{ #category : 'accessing' }
FamixUTActArgument >> value [
	"Relation named: #value type: #FamixValueOfType opposite: #argumentInActs"

	<generated>
	<FMProperty: #value type: #FamixValueOfType opposite: #argumentInActs>
	^ self attributeAt: #value ifAbsent: [ nil ]
]

{ #category : 'accessing' }
FamixUTActArgument >> value: anObject [

	<generated>
	self attributeAt: #value put: (FMMultivalueLink on: self update: #argumentInActs from: self value to: anObject).
]
