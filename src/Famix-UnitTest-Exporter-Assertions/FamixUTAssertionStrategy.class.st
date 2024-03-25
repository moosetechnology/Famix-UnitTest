Class {
	#name : #FamixUTAssertionStrategy,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'Famix-UnitTest-Exporter-Assertions'
}

{ #category : #accessing }
FamixUTAssertionStrategy class >> default [

	self subclassResponsibility
]

{ #category : #accessing }
FamixUTAssertionStrategy class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : #testing }
FamixUTAssertionStrategy class >> isAbstract [

	^ self == FamixUTAssertionStrategy
]

{ #category : #ast }
FamixUTAssertionStrategy >> dependencyImportsOn: aFamixUTExporter [
	"Add the imports of the dependencies required by this strategy."

	^ {  }
]

{ #category : #exporting }
FamixUTAssertionStrategy >> export: aFamixUTAssertion on: aFamixUTExporter [

	self subclassResponsibility
]
