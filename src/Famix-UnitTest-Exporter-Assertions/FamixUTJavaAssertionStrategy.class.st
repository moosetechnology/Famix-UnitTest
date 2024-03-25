Class {
	#name : #FamixUTJavaAssertionStrategy,
	#superclass : #FamixUTAssertionStrategy,
	#category : #'Famix-UnitTest-Exporter-Assertions'
}

{ #category : #accessing }
FamixUTJavaAssertionStrategy class >> default [

	^ FamixUTJUnitAssertEqualsAssertionStrategy instance
]

{ #category : #testing }
FamixUTJavaAssertionStrategy class >> isAbstract [

	^ self == FamixUTJavaAssertionStrategy
]
