Class {
	#name : 'FamixUTMapping',
	#superclass : 'Object',
	#instVars : [
		'mapping'
	],
	#category : 'Famix-UnitTest-Exporter-Mapping',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Mapping'
}

{ #category : 'testing' }
FamixUTMapping class >> isAbstract [

	^ self == FamixUTMapping
]

{ #category : 'instance creation' }
FamixUTMapping class >> on: aFamixUTEntity [

	^ self new model: aFamixUTEntity
]

{ #category : 'accessing' }
FamixUTMapping >> mapping [

	^ mapping ifNil: [ mapping := Dictionary new ]
]
