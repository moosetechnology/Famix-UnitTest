"
Sets up or tears down the system to make tests repeatable.
"
Class {
	#name : #FamixUTFixture,
	#superclass : #FamixUTEntity,
	#instVars : [
		'#setUpInSuite => FMOne type: #FamixUTSuite opposite: #setUp',
		'#tearDownInSuite => FMOne type: #FamixUTSuite opposite: #tearDown',
		'#setUpInCase => FMOne type: #FamixUTCase opposite: #setUp',
		'#tearDownInCase => FMOne type: #FamixUTCase opposite: #tearDown',
		'#setUpInMethod => FMOne type: #FamixUTMethod opposite: #setUp',
		'#tearDownInMethod => FMOne type: #FamixUTMethod opposite: #tearDown'
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

{ #category : #accessing }
FamixUTFixture >> setUpInCase [
	"Relation named: #setUpInCase type: #FamixUTCase opposite: #setUp"

	<generated>
	<derived>
	^ setUpInCase
]

{ #category : #accessing }
FamixUTFixture >> setUpInCase: anObject [

	<generated>
	setUpInCase := anObject
]

{ #category : #accessing }
FamixUTFixture >> setUpInMethod [
	"Relation named: #setUpInMethod type: #FamixUTMethod opposite: #setUp"

	<generated>
	<derived>
	^ setUpInMethod
]

{ #category : #accessing }
FamixUTFixture >> setUpInMethod: anObject [

	<generated>
	setUpInMethod := anObject
]

{ #category : #accessing }
FamixUTFixture >> setUpInSuite [
	"Relation named: #setUpInSuite type: #FamixUTSuite opposite: #setUp"

	<generated>
	<derived>
	^ setUpInSuite
]

{ #category : #accessing }
FamixUTFixture >> setUpInSuite: anObject [

	<generated>
	setUpInSuite := anObject
]

{ #category : #accessing }
FamixUTFixture >> tearDownInCase [
	"Relation named: #tearDownInCase type: #FamixUTCase opposite: #tearDown"

	<generated>
	<derived>
	^ tearDownInCase
]

{ #category : #accessing }
FamixUTFixture >> tearDownInCase: anObject [

	<generated>
	tearDownInCase := anObject
]

{ #category : #accessing }
FamixUTFixture >> tearDownInMethod [
	"Relation named: #tearDownInMethod type: #FamixUTMethod opposite: #tearDown"

	<generated>
	<derived>
	^ tearDownInMethod
]

{ #category : #accessing }
FamixUTFixture >> tearDownInMethod: anObject [

	<generated>
	tearDownInMethod := anObject
]

{ #category : #accessing }
FamixUTFixture >> tearDownInSuite [
	"Relation named: #tearDownInSuite type: #FamixUTSuite opposite: #tearDown"

	<generated>
	<derived>
	^ tearDownInSuite
]

{ #category : #accessing }
FamixUTFixture >> tearDownInSuite: anObject [

	<generated>
	tearDownInSuite := anObject
]
