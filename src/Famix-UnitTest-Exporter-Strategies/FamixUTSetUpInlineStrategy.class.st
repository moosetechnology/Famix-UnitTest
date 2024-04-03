"
I export Arrange elements inline, meaning a method setup or teardown will be entirely written inside the test method.
"
Class {
	#name : #FamixUTSetUpInlineStrategy,
	#superclass : #FamixUTSetUpStrategy,
	#category : #'Famix-UnitTest-Exporter-Strategies'
}

{ #category : #exporting }
FamixUTSetUpInlineStrategy >> export: aFamixUTSetUp on: aFamixUTExporter [

	aFamixUTSetUp values do: [ :value |
		value accept: aFamixUTExporter valueExporter ]
]
