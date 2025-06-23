"
I create a test suite using all of the test classes that were successfully exported.
"
Class {
	#name : 'FamixUTModestSuitePatch',
	#superclass : 'FamixUTAbstractPatch',
	#category : 'Famix-UnitTest-Exporter-Strategies',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Strategies'
}

{ #category : 'hooks' }
FamixUTModestSuitePatch >> after: testExporter exportsTestCases: aFamixUTModel [
	"Create a suite with all test classes that were successfully exported."

	(aFamixUTModel newSuiteNamed: 'ModestSuite') cases:
		(testExporter mapping classes collect: [ :classMapping |
			 classMapping model ])
]
