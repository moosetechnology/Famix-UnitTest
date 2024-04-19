Class {
	#name : #FamixUTAbstractJavaAssertionStrategy,
	#superclass : #FamixUTAbstractStrategy,
	#category : #'Famix-UnitTest-Exporter-Strategies'
}

{ #category : #accessing }
FamixUTAbstractJavaAssertionStrategy class >> default [

	^ FamixUTJUnitJavaAssertionStrategy instance
]

{ #category : #testing }
FamixUTAbstractJavaAssertionStrategy class >> isAbstract [

	^ self == FamixUTAbstractJavaAssertionStrategy
]
