Class {
	#name : 'FamixUTMethodMapping',
	#superclass : 'FamixUTMapping',
	#instVars : [
		'ast',
		'model'
	],
	#category : 'Famix-UnitTest-Exporter-Mapping',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Mapping'
}

{ #category : 'adding' }
FamixUTMethodMapping >> addHelper: anASTEntity named: name [

	^ self mapping at: name put: anASTEntity
]

{ #category : 'accessing' }
FamixUTMethodMapping >> ast [

	^ ast
]

{ #category : 'accessing' }
FamixUTMethodMapping >> ast: anASTEntity [

	ast := anASTEntity
]

{ #category : 'accessing' }
FamixUTMethodMapping >> helpers [

	^ self mapping
]

{ #category : 'accessing' }
FamixUTMethodMapping >> helpers: aDictionary [

	mapping := aDictionary
]

{ #category : 'enumerating' }
FamixUTMethodMapping >> helpersDo: aBlock [

	self mapping valuesDo: aBlock
]

{ #category : 'accessing' }
FamixUTMethodMapping >> model [

	^ model
]

{ #category : 'accessing' }
FamixUTMethodMapping >> model: aFamixUTMethod [

	model := aFamixUTMethod
]
