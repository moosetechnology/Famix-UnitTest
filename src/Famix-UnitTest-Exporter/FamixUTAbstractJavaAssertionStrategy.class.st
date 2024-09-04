Class {
	#name : 'FamixUTAbstractJavaAssertionStrategy',
	#superclass : 'FamixUTAbstractStrategy',
	#category : 'Famix-UnitTest-Exporter-Strategies',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Strategies'
}

{ #category : 'accessing' }
FamixUTAbstractJavaAssertionStrategy class >> default [

	^ FamixUTJUnitJavaAssertionStrategy instance
]

{ #category : 'testing' }
FamixUTAbstractJavaAssertionStrategy class >> isAbstract [

	^ self == FamixUTAbstractJavaAssertionStrategy
]
