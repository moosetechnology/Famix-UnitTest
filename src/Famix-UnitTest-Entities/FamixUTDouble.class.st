"
Object used in testing to replace a real object with a simplified version.
"
Class {
	#name : #FamixUTDouble,
	#superclass : #FamixUTEntity,
	#instVars : [
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
FamixUTDouble >> addFixture: anObject [
	<generated>
	^ self fixtures add: anObject
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
