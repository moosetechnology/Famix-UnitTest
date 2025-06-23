Class {
	#name : 'FamixUTModelMapping',
	#superclass : 'FamixUTMapping',
	#category : 'Famix-UnitTest-Exporter-Mapping',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Mapping'
}

{ #category : 'adding' }
FamixUTModelMapping >> addClass: aFamixUTCase [

	^ self mapping
		  at: aFamixUTCase name
		  put: (FamixUTClassMapping on: aFamixUTCase)
]

{ #category : 'accessing' }
FamixUTModelMapping >> atClass: aFamixUTCase [

	^ self classNamed: aFamixUTCase name
]

{ #category : 'accessing' }
FamixUTModelMapping >> atMethod: aFamixUTMethod [

	^ (self atClass: aFamixUTMethod case) methodNamed:
		  aFamixUTMethod name
]

{ #category : 'accessing' }
FamixUTModelMapping >> classNamed: className [

	^ self mapping at: className
]

{ #category : 'accessing' }
FamixUTModelMapping >> classes [

	^ self mapping
]

{ #category : 'accessing' }
FamixUTModelMapping >> classesDo: aBlock [

	self mapping valuesDo: aBlock
]

{ #category : 'removing' }
FamixUTModelMapping >> removeClass: aFamixUTCase [

	^ self removeClassNamed: aFamixUTCase name
]

{ #category : 'removing' }
FamixUTModelMapping >> removeClassMapping: classMapping [

	^ self removeClass: classMapping model
]

{ #category : 'removing' }
FamixUTModelMapping >> removeClassNamed: className [

	^ self mapping removeKey: className
]
