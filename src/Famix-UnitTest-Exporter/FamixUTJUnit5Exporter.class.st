Class {
	#name : 'FamixUTJUnit5Exporter',
	#superclass : 'FamixUTJUnitExporter',
	#category : 'Famix-UnitTest-Exporter-Exporters',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Exporters'
}

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
