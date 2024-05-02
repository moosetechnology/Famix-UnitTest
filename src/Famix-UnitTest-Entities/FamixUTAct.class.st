"
Execution of the system under test.

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `method` | `FamixUTAct` | `act` | `FamixUTMethod` | |

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `arguments` | `FamixUTAct` | `argumentInAct` | `FamixValueOfType` | |
| `receiver` | `FamixUTAct` | `receiverInAct` | `FamixValueOfType` | |



"
Class {
	#name : #FamixUTAct,
	#superclass : #FamixUTEntity,
	#instVars : [
		'#method => FMOne type: #FamixUTMethod opposite: #act'
	],
	#category : #'Famix-UnitTest-Entities-Entities'
}

{ #category : #meta }
FamixUTAct class >> annotation [

	<FMClass: #Act super: #FamixUTEntity>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	^ self
]

{ #category : #adding }
FamixUTAct >> addArgument: anObject [
	<generated>
	^ self arguments add: anObject
]

{ #category : #accessing }
FamixUTAct >> arguments [
	"Relation named: #arguments type: #FamixValueOfType opposite: #argumentInAct"

	<generated>
	<derived>
	<FMProperty: #arguments type: #FamixValueOfType opposite: #argumentInAct>
	^ self attributeAt: #arguments ifAbsentPut: [ FMMultivalueLink on: self opposite: #argumentInAct: ]
]

{ #category : #accessing }
FamixUTAct >> arguments: anObject [

	<generated>
	self arguments value: anObject
]

{ #category : #accessing }
FamixUTAct >> method [
	"Relation named: #method type: #FamixUTMethod opposite: #act"

	<generated>
	<container>
	<derived>
	^ method
]

{ #category : #accessing }
FamixUTAct >> method: anObject [

	<generated>
	method := anObject
]

{ #category : #navigation }
FamixUTAct >> methodGroup [
	<generated>
	<navigation: 'Method'>
	^ MooseSpecializedGroup with: self method
]

{ #category : #accessing }
FamixUTAct >> receiver [
	"Relation named: #receiver type: #FamixValueOfType opposite: #receiverInAct"

	<generated>
	<FMProperty: #receiver type: #FamixValueOfType opposite: #receiverInAct>
	^ self attributeAt: #receiver ifAbsent: [ nil ]
]

{ #category : #accessing }
FamixUTAct >> receiver: anObject [

	<generated>
	(self attributeAt: #receiver ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self receiver.
		self attributeAt: #receiver put: anObject.
		otherSide receiverInAct: nil ]
	ifNotNil: [ 
		self attributeAt: #receiver put: anObject.
		anObject receiverInAct: self ]
]
