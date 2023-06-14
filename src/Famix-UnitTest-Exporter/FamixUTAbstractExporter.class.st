Class {
	#name : #FamixUTAbstractExporter,
	#superclass : #Object,
	#category : #'Famix-UnitTest-Exporter'
}

{ #category : #exporting }
FamixUTAbstractExporter >> export: aFamixUTModel [

	(aFamixUTModel allWithType: FamixUTCase) do: [ :case | 
		self exportCaseFile: case ].
	(aFamixUTModel allWithType: FamixUTSuite) do: [ :suite | 
		self exportSuite: suite ].
	^ self model
]

{ #category : #exporting }
FamixUTAbstractExporter >> exportAct: aFamixUTAct [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTAbstractExporter >> exportAssertion: aFamixUTAssertion [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTAbstractExporter >> exportCase: aFamixUTCase [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTAbstractExporter >> exportCaseFile: aFamixUTCase [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTAbstractExporter >> exportMethod: aFamixUTMethod [

	self subclassResponsibility
]

{ #category : #exporting }
FamixUTAbstractExporter >> exportSuite: aFamixUTSuite [

	self subclassResponsibility
]

{ #category : #accessing }
FamixUTAbstractExporter >> model [

	self subclassResponsibility
]
