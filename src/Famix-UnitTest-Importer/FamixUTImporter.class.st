Class {
	#name : #FamixUTImporter,
	#superclass : #Object,
	#instVars : [
		'model',
		'nameDict'
	],
	#category : #'Famix-UnitTest-Importer'
}

{ #category : #importing }
FamixUTImporter >> fromOpenTelemetrySpans: spans [
	"Use a collection of FamixOTelSpan from the Famix-OpenTelemetry project as test oracle."

	(spans groupedBy: [ :span | span origin parentType ])
		associationsDo: [ :spansByClass |
			| case |
			case := self model newCase testedClass: spansByClass key.
			spansByClass value do: [ :span |
				case addMethod: (self
						 testMethod: span origin
						 receiver: span receiver
						 arguments: span arguments
						 expected: span result) ] ].
	^ self model
]

{ #category : #initialization }
FamixUTImporter >> initialize [

	nameDict := Dictionary new
]

{ #category : #accessing }
FamixUTImporter >> model [

	^ model ifNil: [ model := FamixUTModel new ]
]

{ #category : #accessing }
FamixUTImporter >> model: aFamixUTModel [

	model := aFamixUTModel
]

{ #category : #importing }
FamixUTImporter >> testMethod: aFamixTMethod receiver: receiver arguments: arguments expected: expected [
	"Build a unit test for a method using the given arguments and expected result."

	| method setUp |
	method := self model newMethod
		          testedMethod: aFamixTMethod;
		          name: (self testMethodNameFor: aFamixTMethod).
	setUp := (receiver isNotNil or: [
		          expected isNotNil or: [ arguments isNotEmpty ] ]) ifTrue: [
		         model newSetUp method: method ].
	expected ifNotNil: [
		setUp addValue: expected.
		model newAssertion
			method: method;
			expected: expected ].
	arguments do: [ :argument | setUp addValue: argument value ].
	model newAct
		method: method;
		arguments: (arguments collect: [ :argument |
					 model newActArgument value: argument value ]).
	receiver ifNotNil: [
		setUp addValue: receiver.
		method act receiver: receiver ].
	^ method
]

{ #category : #importing }
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
