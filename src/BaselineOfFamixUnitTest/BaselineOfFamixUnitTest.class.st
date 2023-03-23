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
]

{ #category : #baselines }
BaselineOfFamixUnitTest >> groups: spec [

	spec
		group: 'default' with: #( 'model' );
		group: 'model'
		with: #( 'Famix-UnitTest-Generator' 'Famix-UnitTest-Entities' )
]

{ #category : #baselines }
BaselineOfFamixUnitTest >> packages: spec [

	spec
		package: 'Famix-UnitTest-Generator';
		package: 'Famix-UnitTest-Entities'
]
