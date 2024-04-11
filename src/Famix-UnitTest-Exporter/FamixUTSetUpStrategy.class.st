"
I define how Arrange elements are exported.
"
Class {
	#name : #FamixUTSetUpStrategy,
	#superclass : #FamixUTStrategy,
	#category : #'Famix-UnitTest-Exporter-Strategies'
}

{ #category : #accessing }
FamixUTSetUpStrategy class >> default [

	^ FamixUTSetUpInlineStrategy instance
]

{ #category : #testing }
FamixUTSetUpStrategy class >> isAbstract [

	^ self == FamixUTSetUpStrategy
]

{ #category : #exporting }
FamixUTSetUpStrategy >> export: aFamixUTSetUp on: aFamixUTExporter [

	self subclassResponsibility
]
