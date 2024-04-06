Class {
	#name : #FamixUTJavaAssertionStrategy,
	#superclass : #FamixUTStrategy,
	#category : #'Famix-UnitTest-Exporter-Strategies'
}

{ #category : #accessing }
FamixUTJavaAssertionStrategy class >> default [

	^ FamixUTJUnitAssertEqualsAssertionStrategy instance
]

{ #category : #testing }
FamixUTJavaAssertionStrategy class >> isAbstract [

	^ self == FamixUTJavaAssertionStrategy
]
