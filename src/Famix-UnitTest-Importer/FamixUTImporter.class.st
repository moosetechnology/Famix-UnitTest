Class {
	#name : 'FamixUTImporter',
	#superclass : 'Object',
	#instVars : [
		'model',
		'nameDict'
	],
	#category : 'Famix-UnitTest-Importer',
	#package : 'Famix-UnitTest-Importer'
}

{ #category : 'importing' }
FamixUTImporter >> filterSpans: spans [

	| filteredSpans |
	filteredSpans := spans reject: [ :span | span skipped ].
	self logOpenTelemetrySpans: spans filtered: filteredSpans.
	^ filteredSpans
]

{ #category : 'importing' }
FamixUTImporter >> fromOpenTelemetrySpans: spans [
	"Use a collection of FamixOTelSpan from the Famix-OpenTelemetry project as test oracle."

	| filteredSpans |
	filteredSpans := self filterSpans: spans.
	(filteredSpans groupedBy: [ :span | span origin parentType ])
		keysAndValuesDo: [ :testedClass :classSpans |
			self
				execute: [
					self logOpenTelemetrySpansGroupedByClass: classSpans.
					self testClass: testedClass withOpenTelemetrySpans: classSpans ]
				recordedAs: (String streamContents: [ :s |
						 s << testedClass mooseName << ': '.
						 classSpans size printOn: s.
						 s nextPutAll: ' traces.' ]) ].
	^ self model
]

{ #category : 'initialization' }
FamixUTImporter >> initialize [

	nameDict := Dictionary new
]

{ #category : 'importing' }
FamixUTImporter >> logOpenTelemetrySpans: spans filtered: filteredSpans [
	"Log how many:
	- traces are used to generate tests,
	- traces were processed,
	- traces were skipped,
	- classes are covered,
	- methods are covered"

	[
	String streamContents: [ :s |
		s nextPutAll: 'Using '.
		filteredSpans size printOn: s.
		s nextPut: $/.
		spans size printOn: s.
		s nextPutAll: ' traces ('.
		spans size - filteredSpans size printOn: s.
		s nextPutAll: ' skipped during import) covering '.
		(filteredSpans groupedBy: [ :span | span origin parentType ]) size
			printOn: s.
		s nextPutAll: ' classes and '.
		(filteredSpans groupedBy: [ :span | span origin ]) size printOn: s.
		s nextPutAll: ' methods.' ] ] record
]

{ #category : 'importing' }
FamixUTImporter >> logOpenTelemetrySpansGroupedByClass: spans [
	"Log which methods were traced and how many times."

	| sorted padding |
	TinyCurrentLogger value hasLoggers ifFalse: [ ^ self ].
	sorted := (spans groupedBy: [ :span | span origin ]) associations
		          sort: [ :a :b | a value size >= b value size ].

	"Measure padding to right-align trace count"
	padding := 0.
	sorted do: [ :assoc | padding := padding max: assoc value size ].
	padding := padding asString size.

	sorted do: [ :spansByMethod |
		| testedMethod methodSpans |
		testedMethod := spansByMethod key.
		methodSpans := spansByMethod value.
		(String streamContents: [ :s |
			 s << (methodSpans size asString padLeftTo: padding) << ' trace'.
			 s nextPut: (methodSpans size = 1
					  ifTrue: [ Character space ]
					  ifFalse: [ $s ]).
			 s << ': ' << testedMethod signature ]) record ]
]

{ #category : 'accessing' }
FamixUTImporter >> model [

	^ model ifNil: [ model := FamixUTModel new ]
]

{ #category : 'accessing' }
FamixUTImporter >> model: aFamixUTModel [

	model := aFamixUTModel
]

{ #category : 'importing' }
FamixUTImporter >> testClass: testedClass withOpenTelemetrySpans: spans [

	| case |
	case := self model newCase testedClass: testedClass.
	spans do: [ :span |
		case addMethod: (self
				 testMethod: span origin
				 receiver: span receiver
				 arguments: span arguments
				 expected: span result) ]
]

{ #category : 'importing' }
FamixUTImporter >> testMethod: aFamixTMethod receiver: receiver arguments: arguments expected: expected [
	"Build a unit test for a method using the given receiver, arguments, and expected result."

	| method setUp |
	method := self model newMethod
		          testedMethod: aFamixTMethod;
		          name: (self testMethodNameFor: aFamixTMethod).
	model newAct
		method: method;
		arguments: (arguments collect: [ :argument |
					 model newActArgument value: argument value ]).
	setUp := (receiver isNotNil or: [
		          expected isNotNil or: [ arguments isNotEmpty ] ]) ifTrue: [
		         model newSetUp method: method ].
	receiver ifNotNil: [
		setUp addValue: receiver.
		method act receiver: receiver ].
	arguments do: [ :argument | setUp addValue: argument value ].
	expected ifNotNil: [
		setUp addValue: expected.
		model newAssertion
			method: method;
			expected: expected ].
	^ method
]

{ #category : 'importing' }
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
