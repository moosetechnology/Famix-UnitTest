Class {
	#name : #FamixUTJUnit4Exporter,
	#superclass : #FamixUTJUnitExporter,
	#category : #'Famix-UnitTest-Exporter'
}

{ #category : #naming }
FamixUTJUnit4Exporter >> nameOfAssertionsClass [

	^ 'Assert'
]

{ #category : #'as yet unclassified' }
FamixUTJUnit4Exporter >> nameOfBeforeEachAnnotation [

	^ 'Before'
]

{ #category : #naming }
FamixUTJUnit4Exporter >> nameOfJUnitPackage [

	^ 'org.junit'
]
