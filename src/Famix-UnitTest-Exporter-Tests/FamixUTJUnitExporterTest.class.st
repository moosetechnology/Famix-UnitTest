"
A FamixUTJUnitExporterTest is a test class for testing the behavior of FamixUTJUnitExporter
"
Class {
	#name : #FamixUTJUnitExporterTest,
	#superclass : #TestCase,
	#category : #'Famix-UnitTest-Exporter-Tests'
}

{ #category : #tests }
FamixUTJUnitExporterTest >> testExportMethod [

	| method assertion expected setUp |
	method := FamixUTMethod new testedMethod:
		          (FamixJavaMethod new name: 'foo').
	expected := FamixUTDouble new.
	assertion := FamixUTAssertion new expected: expected.
	setUp := FamixUTSetUp new.

	"empty test"
	self
		assert: (FASTJavaExportVisitor new export:
				 (FamixUTJUnitExporter new exportMethod: method))
		equals: '@Test
public void testFoo() {
}
'
]
