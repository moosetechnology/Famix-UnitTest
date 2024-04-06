Class {
	#name : #FamixUTSUnitExporter,
	#superclass : #FamixUTAbstractExporter,
	#category : #'Famix-UnitTest-Exporter'
}

{ #category : #'instance creation' }
FamixUTSUnitExporter >> newValueExporter [

	^ FamixValue2PharoVisitor new
]
