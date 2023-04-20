Class {
	#name : #BaselineOfFamixUnitTest,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamixUnitTest
}

{ #category : #baselines }
BaselineOfFamixUnitTest >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		self dependencies: spec.
		self packages: spec.
		self groups: spec ]
]

{ #category : #baselines }
BaselineOfFamixUnitTest >> dependencies: spec [

	spec
		baseline: 'FamixValue'
		with: [ 
		spec repository: 'github://moosetechnology/Famix-Value:main/src' ]
]

{ #category : #baselines }
BaselineOfFamixUnitTest >> groups: spec [

	spec
		group: 'default' with: #( 'model' 'importer' 'exporter' );
		group: 'model'
		with: #( 'Famix-UnitTest-Generator' 'Famix-UnitTest-Entities' );
		group: 'importer' with: #( 'Famix-UnitTest-Importer' );
		group: 'exporter'
		with: #( 'Famix-UnitTest-Exporter' 'Famix-UnitTest-Exporter-Tests' )
]

{ #category : #baselines }
BaselineOfFamixUnitTest >> packages: spec [

	spec
		package: 'Famix-UnitTest-Generator';
		package: 'Famix-UnitTest-Entities';
		package: 'Famix-UnitTest-Importer'
		with: [ spec requires: #( 'Famix-UnitTest-Entities' ) ];
		package: 'Famix-UnitTest-Exporter'
		with: [ spec requires: #( 'Famix-UnitTest-Entities' ) ];
		package: 'Famix-UnitTest-Exporter-Tests'
		with: [ spec requires: #( 'Famix-UnitTest-Exporter' ) ]
]
