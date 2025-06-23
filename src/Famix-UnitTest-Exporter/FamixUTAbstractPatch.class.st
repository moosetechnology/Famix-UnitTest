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
FamixUTAbstractPatch >> after: testExporter exports: testModel [
	"At the very end of the test export process."
]

{ #category : 'hooks' }
FamixUTAbstractPatch >> after: testExporter exportsTestCases: aFamixUTModel [
	"All test cases have been exported."
]

{ #category : 'hooks' }
FamixUTAbstractPatch >> after: testExporter exportsTestSuites: aFamixUTModel [
	"All test suites have been exported."
]

{ #category : 'hooks' }
FamixUTAbstractPatch >> before: testExporter exports: aFamixUTModel [
	"At the very start of the test export process."
]

{ #category : 'hooks' }
FamixUTAbstractPatch >> before: testExporter exportsTestCases: aFamixUTModel [
	"All test cases are about to be exported."
]

{ #category : 'hooks' }
FamixUTAbstractPatch >> before: testExporter exportsTestSuites: aFamixUTModel [
	"All test suites are about to be exported."
]

{ #category : 'hooks' }
FamixUTAbstractPatch >> when: testExporter builtTestCase: aFamixUTCase [
	"The test class and its methods have been fully exported."
]

{ #category : 'hooks' }
FamixUTAbstractPatch >> when: testExporter createdTestCase: aFamixUTCase [
	"A test class has just been created, before exporting methods."
]

{ #category : 'hooks' }
FamixUTAbstractPatch >> when: testExporter removedTestCase: aFamixUTCase [
	"A test class has been removed because it has no test methods."
]

{ #category : 'hooks' }
FamixUTAbstractPatch >> when: testExporter skippedTestMethod: aFamixUTMethod because: exception [
	"A test method has been skipped because of an exception."
]
