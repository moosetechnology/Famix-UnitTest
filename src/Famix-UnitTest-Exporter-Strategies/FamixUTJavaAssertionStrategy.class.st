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

{ #category : #ast }
FamixUTJavaAssertionStrategy >> dependencyImportsOn: aFamixUTExporter [
	"Add the imports of the dependencies required by this strategy."

	^ {  }
]
