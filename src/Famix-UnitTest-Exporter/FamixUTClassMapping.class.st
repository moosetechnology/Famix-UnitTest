Class {
	#name : 'FamixUTClassMapping',
	#superclass : 'FamixUTMapping',
	#instVars : [
		'model',
		'comment',
		'ast'
	],
	#category : 'Famix-UnitTest-Exporter-Mapping',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Mapping'
}

{ #category : 'adding' }
FamixUTClassMapping >> addMethod: aFamixUTMethod [

	^ self mapping
		  at: aFamixUTMethod name
		  put: (FamixUTMethodMapping on: aFamixUTMethod)
]

{ #category : 'accessing' }
FamixUTClassMapping >> ast [

	^ ast
]

{ #category : 'accessing' }
FamixUTClassMapping >> ast: anASTEntity [

	ast := anASTEntity
]

{ #category : 'accessing' }
FamixUTClassMapping >> comment [

	^ comment
]

{ #category : 'accessing' }
FamixUTClassMapping >> comment: aString [

	comment := aString
]

{ #category : 'enumerating' }
FamixUTClassMapping >> methodNamed: methodName [

	^ self mapping at: methodName
]

{ #category : 'accessing' }
FamixUTClassMapping >> methods [

	^ self mapping
]

{ #category : 'accessing' }
FamixUTClassMapping >> methods: aDictionary [

	mapping := aDictionary
]

{ #category : 'accessing' }
FamixUTClassMapping >> methodsDo: aBlock [

	self mapping valuesDo: aBlock
]

{ #category : 'accessing' }
FamixUTClassMapping >> model [

	^ model
]

{ #category : 'accessing' }
FamixUTClassMapping >> model: aFamixUTCase [

	model := aFamixUTCase
]

{ #category : 'removing' }
FamixUTClassMapping >> removeMethod: aFamixUTMethod [

	^ self removeMethodNamed: aFamixUTMethod name
]

{ #category : 'removing' }
FamixUTClassMapping >> removeMethodMapping: methodMapping [

	^ self removeMethod: methodMapping model
]

{ #category : 'removing' }
FamixUTClassMapping >> removeMethodNamed: methodName [

	| removed |
	removed := self mapping removeKey: methodName.

	removed ast ifNotNil: [ :removedAST |
		removedAST isMooseObject ifTrue: [ "Remove from owner using metadescription"
			self halt ] ].

	^ removed
]
