"
Sets up or tears down the system to make tests repeatable.
"
Class {
	#name : #FamixUTFixture,
	#superclass : #FamixUTEntity,
	#category : #'Famix-UnitTest-Entities-Entities'
}

{ #category : #meta }
FamixUTFixture class >> annotation [

	<FMClass: #Fixture super: #FamixUTEntity>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	<abstract>
	^ self
]

{ #category : #testing }
FamixUTFixture class >> isAbstract [

	<generated>
	^ self == FamixUTFixture
]

{ #category : #adding }
FamixUTFixture >> addDouble: anObject [
	<generated>
	^ self doubles add: anObject
]

{ #category : #accessing }
FamixUTFixture >> doubles [
	"Relation named: #doubles type: #FamixValueOfType opposite: #fixtures"

	<generated>
	<derived>
	<FMProperty: #doubles type: #FamixValueOfType opposite: #fixtures>
	^ self attributeAt: #doubles ifAbsentPut: [ FMMultiMultivalueLink on: self opposite: #fixtures ]
]

{ #category : #accessing }
FamixUTFixture >> doubles: anObject [

	<generated>
	self doubles value: anObject
]
