Class {
	#name : #FamixUTImporter,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Famix-UnitTest-Importer'
}

{ #category : #'instance creation' }
FamixUTImporter >> model [

	^ model ifNil: [ model := FamixUTModel new ]
]

{ #category : #'instance creation' }
FamixUTImporter >> model: aModel [

	model := aModel
]

{ #category : #'instance creation' }
FamixUTImporter >> newAssertion [

	^ self model add: FamixUTAssertion new
]

{ #category : #'instance creation' }
FamixUTImporter >> newCase [

	^ self model add: FamixUTCase new
]

{ #category : #'instance creation' }
FamixUTImporter >> newDouble [

	^ self model add: FamixUTDouble new
]

{ #category : #'instance creation' }
FamixUTImporter >> newMethod [

	^ self model add: FamixUTMethod new
]

{ #category : #'instance creation' }
FamixUTImporter >> newSetUp [

	^ self model add: FamixUTSetUp new
]

{ #category : #'instance creation' }
FamixUTImporter >> newSuite [

	^ self model add: FamixUTSuite new
]

{ #category : #'instance creation' }
FamixUTImporter >> newTearDown [

	^ self model add: FamixUTTearDown new
]
