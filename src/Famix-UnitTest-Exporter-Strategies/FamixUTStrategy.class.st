Class {
	#name : #FamixUTStrategy,
	#superclass : #Object,
	#classInstVars : [
		'instance'
	],
	#category : #'Famix-UnitTest-Exporter-Strategies'
}

{ #category : #accessing }
FamixUTStrategy class >> default [

	self subclassResponsibility
]

{ #category : #accessing }
FamixUTStrategy class >> instance [

	^ instance ifNil: [
		  self isAbstract ifTrue: [
			  Error signal: 'Should not use abstract strategy.' ].
		  instance := self new ]
]

{ #category : #accessing }
FamixUTStrategy class >> isAbstract [

	^ self == FamixUTStrategy
]

{ #category : #ast }
FamixUTStrategy >> dependencyImportsOn: aFamixUTExporter [
	"Generate the dependency imports required by this strategy."

	^ {  }
]

{ #category : #exporting }
FamixUTStrategy >> export: aFamixUTEntity on: aFamixUTExporter [

	self subclassResponsibility
]
