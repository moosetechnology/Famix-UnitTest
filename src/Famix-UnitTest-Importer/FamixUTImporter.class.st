Class {
	#name : #FamixUTImporter,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Famix-UnitTest-Importer'
}

{ #category : #'instance creation' }
FamixUTImporter >> model [

	^ model ifNil: [ model := FamixUTModel new ]
]

{ #category : #'instance creation' }
FamixUTImporter >> model: aModel [

	model := aModel
]

{ #category : #tests }
FamixUTImporter >> testMethod: aFamixTMethod arguments: arguments expected: expected [

	"Build a unit test for a method using the given arguments and expected result."

	| method double |
	method := self model newMethod testedMethod: aFamixTMethod.
	double := model newDouble value: expected.
	model newSetUp
		method: method;
		addDouble: double.
	model newAssertion
		method: method;
		arguments: arguments;
		expected: double.
	^ method
]
