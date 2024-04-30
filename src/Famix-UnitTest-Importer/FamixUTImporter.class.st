Class {
	#name : #FamixUTImporter,
	#superclass : #Object,
	#instVars : [
		'model',
		'nameDict'
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

{ #category : #initialization }
FamixUTImporter >> initialize [

	nameDict := Dictionary new
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

	| method setUp |
	method := self model newMethod
		          testedMethod: aFamixTMethod;
		          name: (self testMethodNameFor: aFamixTMethod).
	setUp := (expected isNotNil or: [ arguments isNotEmpty ]) ifTrue: [
		         model newSetUp method: method ].
	expected ifNotNil: [
		setUp addValue: expected.
		model newAssertion
			method: method;
			expected: expected ].
	arguments do: [ :argument | setUp addValue: argument ].
	model newAct
		method: method;
		arguments: arguments.
	^ method
]

{ #category : #tests }
FamixUTImporter >> testMethodNameFor: aFamixTMethod [
	"Give a unique name for a new test method."

	| name nameID |
	nameID := nameDict
		          at: (name := aFamixTMethod name asSymbol asTestSelector)
		          ifPresent: [ :id | nameDict at: name put: id + 1 ]
		          ifAbsentPut: [ 1 ].
	^ nameID == 1
		  ifTrue: [ name ]
		  ifFalse: [ name , nameID asString ]
]
