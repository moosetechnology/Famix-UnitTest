Class {
	#name : #FamixUTAbstractStrategy,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'Famix-UnitTest-Exporter-Strategies'
}

{ #category : #accessing }
FamixUTAbstractStrategy class >> default [

	self subclassResponsibility
]

{ #category : #accessing }
FamixUTAbstractStrategy class >> instance [

	self isAbstract ifTrue: [
		Error signal: 'Should not use abstract strategy.' ].
	^ instance ifNil: [ instance := self new ]
]

{ #category : #accessing }
FamixUTAbstractStrategy class >> isAbstract [

	^ self == FamixUTAbstractStrategy
]

{ #category : #ast }
FamixUTAbstractStrategy >> dependencyImportsOn: aFamixUTExporter [
	"Generate the dependency imports required by this strategy."

	^ {  }
]

{ #category : #exporting }
FamixUTAbstractStrategy >> export: aFamixUTEntity on: aFamixUTExporter [

	self subclassResponsibility
]
