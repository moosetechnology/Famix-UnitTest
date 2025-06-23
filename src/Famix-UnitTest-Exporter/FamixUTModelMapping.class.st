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

{ #category : 'accessing' }
FamixUTModelMapping >> log [

	| classCount methodCount helperCount dict |
	TinyCurrentLogger value hasLoggers ifFalse: [ ^ self ].
	classCount := mapping size.
	methodCount := helperCount := 0.
	dict := Dictionary new: classCount.

	self classesDo: [ :classMapping |
		methodCount := methodCount + classMapping mapping size.
		classMapping methodsDo: [ :methodMapping |
			helperCount := helperCount + methodMapping helpers size.
			(dict
				 at: classMapping model fullyQualifiedName
				 at: methodMapping model testedMethod mooseName
				 ifAbsentPut: [ Dictionary new ])
				at: methodMapping model fullyQualifiedName
				put: (methodMapping helpers values collect: [ :helper |
						 helper fullyQualifiedName ]) ] ].

	(String streamContents: [ :s |
		 s << 'Generated tests include '.
		 classCount printOn: s.
		 s << ' test class'.
		 classCount = 1 ifFalse: [ s << 'es' ].
		 s << ', '.
		 methodCount printOn: s.
		 s << ' test method'.
		 methodCount = 1 ifFalse: [ s nextPut: $s ].
		 s << ', '.
		 helperCount printOn: s.
		 s << ' helper'.
		 helperCount = 1 ifFalse: [ s nextPut: $s ].
		 s << '.' ]) record.

	(String streamContents: [ :s | "Test classes and covered classes should be 1:1"
		 | covered |
		 s << 'Generated tests cover '.
		 covered := self classes groupedBy: [ :classMapping |
			            classMapping model testedClass ].
		 covered size printOn: s.
		 s << ' class'.
		 covered size = 1 ifFalse: [ s << 'es' ].
		 s << ' and '.
		 covered := (self classes flatCollect: [ :classMapping |
			             classMapping methods ]) groupedBy: [ :methodMapping |
			            methodMapping model testedMethod ].
		 covered size printOn: s.
		 s << ' method'.
		 covered size = 1 ifFalse: [ s nextPut: $s ].
		 s nextPut: $. ]) record.

	'Printing generated test structure in JSON, as testClass -> testedMethod -> testMethod -> helpers:'
		record.
	(STON toJsonString: dict) record
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
