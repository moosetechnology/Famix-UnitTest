Class {
	#name : #FamixUTSUnitExporter,
	#superclass : #FamixUTExporter,
	#category : #'Famix-UnitTest-Exporter-Exporters'
}

{ #category : #'instance creation' }
FamixUTSUnitExporter >> newValueExporter [

	^ FamixValue2PharoVisitor new
]
