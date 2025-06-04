Class {
	#name : 'FamixUTJUnit4Exporter',
	#superclass : 'FamixUTJUnitExporter',
	#category : 'Famix-UnitTest-Exporter-Exporters',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Exporters'
}

{ #category : 'ast' }
FamixUTJUnit4Exporter >> makeSuiteAnnotations: aFamixUTSuite [

	^ {
		  (model newAnnotation
			   name: 'RunWith';
			   elements: { (model newClassProperty
					    type: (model newIdentifier name: 'Suite');
					    fieldName: 'class') }).
		  (model newAnnotation
			   name: 'SuiteClasses';
			   elements: { (model newArrayAnnotationElement values:
						    (aFamixUTSuite cases collect: [ :case |
								     model newClassProperty
									     type: (model newIdentifier name: case name);
									     fieldName: 'class' ])) }) }
]

{ #category : 'ast' }
FamixUTJUnit4Exporter >> makeSuiteImports [

	^ {
		  (model newImportDeclaration qualifiedName:
			   (model newQualifiedName name: 'org.junit.runner.RunWith')).
		  (model newImportDeclaration qualifiedName:
			   (model newQualifiedName name: 'org.junit.runners.Suite')).
		  (model newImportDeclaration qualifiedName:
			   (model newQualifiedName name:
				    'org.junit.runners.Suite.SuiteClasses')) }
]

{ #category : 'naming' }
FamixUTJUnit4Exporter >> nameOfAssertionsClass [

	^ 'Assert'
]

{ #category : 'naming' }
FamixUTJUnit4Exporter >> nameOfBeforeEachAnnotation [

	^ 'Before'
]

{ #category : 'naming' }
FamixUTJUnit4Exporter >> nameOfJUnitPackage [

	^ 'org.junit'
]
