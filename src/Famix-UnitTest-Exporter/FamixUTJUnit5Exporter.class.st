Class {
	#name : #FamixUTJUnit5Exporter,
	#superclass : #FamixUTJUnitExporter,
	#category : #'Famix-UnitTest-Exporter'
}

{ #category : #naming }
FamixUTJUnit5Exporter >> nameOfAssertionsClass [

	^ 'Assertions'
]

{ #category : #'as yet unclassified' }
FamixUTJUnit5Exporter >> nameOfBeforeEachAnnotation [

	^ 'BeforeEach'
]

{ #category : #naming }
FamixUTJUnit5Exporter >> nameOfJUnitPackage [

	^ 'org.junit.jupiter.api'
]
