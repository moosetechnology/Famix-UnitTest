"
Patches target specific part of the exporter's pipeline to adjust the generated tests.
"
Class {
	#name : 'FamixUTAbstractPatch',
	#superclass : 'Object',
	#category : 'Famix-UnitTest-Exporter-Strategies',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Strategies'
}

{ #category : 'testing' }
FamixUTAbstractPatch class >> isAbstract [

	^ self == FamixUTAbstractPatch
]

{ #category : 'hooks' }
FamixUTAbstractPatch >> whenTestCaseBuilt: aFamixUTCase on: testExporter [
	"The test class and its methods have been fully exported."
]

{ #category : 'hooks' }
FamixUTAbstractPatch >> whenTestCaseCreated: aFamixUTCase on: testExporter [
	"A test class has just been created."
]
