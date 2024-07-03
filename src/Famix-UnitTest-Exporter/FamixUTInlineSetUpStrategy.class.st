"
I export Arrange elements inline, meaning a method setup or teardown will be entirely written inside the test method.
"
Class {
	#name : #FamixUTInlineSetUpStrategy,
	#superclass : #FamixUTAbstractSetUpStrategy,
	#category : #'Famix-UnitTest-Exporter-Strategies'
}

{ #category : #ast }
FamixUTInlineSetUpStrategy >> dependencyImportsOn: aFamixUTExporter [

	^ aFamixUTExporter valueExporter objectExportStrategy
		  dependencyImportsOn: aFamixUTExporter model
]

{ #category : #exporting }
FamixUTInlineSetUpStrategy >> export: aFamixUTSetUp on: aFamixUTExporter [

	^ aFamixUTSetUp values collect: [ :value |
		  | newNode |
		  newNode := aFamixUTExporter valueExporter ensureVisited: value.
		  value isReferencedInLoop ifTrue: [
			  newNode := newNode addParenthesisToVariable].
		  newNode ]
]
