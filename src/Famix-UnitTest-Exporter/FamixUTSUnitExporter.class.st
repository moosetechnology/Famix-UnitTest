Class {
	#name : #FamixUTSUnitExporter,
	#superclass : #FamixUTAbstractExporter,
	#category : #'Famix-UnitTest-Exporter'
}

{ #category : #accessing }
FamixUTSUnitExporter >> newValueExporter [

	^ FamixValue2PharoVisitor new
]
