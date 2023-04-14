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

	| method |
	method := FamixUTMethod new name: 'test'.
	self
		assert: (FASTJavaExportVisitor new export:
				 (FamixUTJUnitExporter new exportMethod: method))
		equals: '@Test
public void test() {
}
'
]
