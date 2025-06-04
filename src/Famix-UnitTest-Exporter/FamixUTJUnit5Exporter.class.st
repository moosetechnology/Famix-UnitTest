Class {
	#name : 'FamixUTJUnit5Exporter',
	#superclass : 'FamixUTJUnitExporter',
	#category : 'Famix-UnitTest-Exporter-Exporters',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Exporters'
}

{ #category : 'ast' }
FamixUTJUnit5Exporter >> makeSuiteAnnotations: aFamixUTSuite [

	^ {
		  (model newAnnotation name: 'Suite').
		  (model newAnnotation
			   name: 'SelectClasses';
			   elements: { (model newArrayAnnotationElement values:
						    (aFamixUTSuite cases collect: [ :case |
								     model newClassProperty
									     type: (model newIdentifier name: case name);
									     fieldName: 'class' ])) }) }
]

{ #category : 'ast' }
FamixUTJUnit5Exporter >> makeSuiteImports [

	^ {
		  (model newImportDeclaration qualifiedName:
			   (model newQualifiedName name:
				    'org.junit.platform.suite.api.Suite')).
		  (model newImportDeclaration qualifiedName:
			   (model newQualifiedName name:
				    'org.junit.platform.suite.api.SelectClasses')) }
]

{ #category : 'naming' }
FamixUTJUnit5Exporter >> nameOfAssertionsClass [

	^ 'Assertions'
]

{ #category : 'naming' }
FamixUTJUnit5Exporter >> nameOfBeforeEachAnnotation [

	^ 'BeforeEach'
]

{ #category : 'naming' }
FamixUTJUnit5Exporter >> nameOfJUnitPackage [

	^ 'org.junit.jupiter.api'
]
