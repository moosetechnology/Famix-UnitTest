"
I define how Arrange elements are exported.
"
Class {
	#name : #FamixUTAbstractSetUpStrategy,
	#superclass : #FamixUTAbstractStrategy,
	#category : #'Famix-UnitTest-Exporter-Strategies'
}

{ #category : #accessing }
FamixUTAbstractSetUpStrategy class >> default [

	^ FamixUTInlineSetUpStrategy instance
]

{ #category : #testing }
FamixUTAbstractSetUpStrategy class >> isAbstract [

	^ self == FamixUTAbstractSetUpStrategy
]

{ #category : #exporting }
FamixUTAbstractSetUpStrategy >> export: aFamixUTSetUp on: aFamixUTExporter [

	self subclassResponsibility
]
