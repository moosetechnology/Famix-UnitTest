Class {
	#name : #FamixUTSUnitExporter,
	#superclass : #FamixUTAbstractExporter,
	#category : #'Famix-UnitTest-Exporter-Exporters'
}

{ #category : #'instance creation' }
FamixUTSUnitExporter >> newValueExporter [

	^ FamixValue2PharoVisitor new
]
