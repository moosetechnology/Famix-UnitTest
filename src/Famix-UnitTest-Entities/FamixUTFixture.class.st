"
Sets up or tears down the system to make tests repeatable.
"
Class {
	#name : #FamixUTFixture,
	#superclass : #FamixUTEntity,
	#instVars : [
		'#doubles => FMMany type: #FamixUTDouble opposite: #fixtures'
	],
	#category : #'Famix-UnitTest-Entities-Entities'
}

{ #category : #meta }
FamixUTFixture class >> annotation [

	<FMClass: #Fixture super: #FamixUTEntity>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	^ self
]

{ #category : #adding }
FamixUTFixture >> addDouble: anObject [
	<generated>
	^ self doubles add: anObject
]

{ #category : #accessing }
FamixUTFixture >> doubles [
	"Relation named: #doubles type: #FamixUTDouble opposite: #fixtures"

	<generated>
	<derived>
	^ doubles
]

{ #category : #accessing }
FamixUTFixture >> doubles: anObject [

	<generated>
	doubles value: anObject
]
