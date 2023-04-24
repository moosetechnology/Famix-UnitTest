"
This trait is used by Famix models.
It provides an API for creating new entities and adding them in the model.
"
Trait {
	#name : #FamixUTTEntityCreator,
	#category : #'Famix-UnitTest-Entities-Model'
}

{ #category : #meta }
FamixUTTEntityCreator classSide >> annotation [

	<FMClass: #TEntityCreator super: #Object>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	^ self
]

{ #category : #'entity creation' }
FamixUTTEntityCreator >> newAct [

	<generated>
	^ self add: FamixUTAct new
]

{ #category : #'entity creation' }
FamixUTTEntityCreator >> newAssertion [

	<generated>
	^ self add: FamixUTAssertion new
]

{ #category : #'entity creation' }
FamixUTTEntityCreator >> newCase [

	<generated>
	^ self add: FamixUTCase new
]

{ #category : #'entity creation' }
FamixUTTEntityCreator >> newMethod [

	<generated>
	^ self add: FamixUTMethod new
]

{ #category : #'entity creation' }
FamixUTTEntityCreator >> newMethodNamed: aName [

	<generated>
	^ self add: (FamixUTMethod named: aName)
]

{ #category : #'entity creation' }
FamixUTTEntityCreator >> newSetUp [

	<generated>
	^ self add: FamixUTSetUp new
]

{ #category : #'entity creation' }
FamixUTTEntityCreator >> newSuite [

	<generated>
	^ self add: FamixUTSuite new
]

{ #category : #'entity creation' }
FamixUTTEntityCreator >> newTearDown [

	<generated>
	^ self add: FamixUTTearDown new
]
