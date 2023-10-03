Class {
	#name : #FamixUTImporter,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Famix-UnitTest-Importer'
}

{ #category : #'instance creation' }
FamixUTImporter >> fromOpenTelemetrySpans: spans [

	"Use a collection of FamixOTelSpan from the Famix-OpenTelemetry project as test oracle."

	(spans groupedBy: [ :span | span origin parentType ]) 
		associationsDo: [ :spansByClass | 
			| case |
			case := self model newCase testedClass: spansByClass key.
			spansByClass value do: [ :span | 
				case addMethod: (self
						 testMethod: span origin
						 arguments: span arguments
						 expected: span result) ] ].
	^ model
]

{ #category : #'instance creation' }
FamixUTImporter >> model [

	^ model ifNil: [ model := FamixUTModel new ]
]

{ #category : #'instance creation' }
FamixUTImporter >> model: aFamixUTModel [

	model := aFamixUTModel
]

{ #category : #tests }
FamixUTImporter >> testMethod: aFamixTMethod arguments: arguments expected: expected [

	"Build a unit test for a method using the given arguments and expected result."

	| method |
	method := self model newMethod
		          testedMethod: aFamixTMethod;
		          name: 'test' , aFamixTMethod name capitalized.
	model newSetUp
		method: method;
		addValue: expected.
	model newAssertion
		method: method;
		expected: expected.
	model newAct
		method: method;
		arguments: arguments.
	^ method
]
