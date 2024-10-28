"
A class containing test methods.

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `suite` | `FamixUTCase` | `cases` | `FamixUTSuite` | |

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `methods` | `FamixUTCase` | `case` | `FamixUTMethod` | |

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `afterAll` | `FamixUTCase` | `forAllInCase` | `FamixUTTearDown` | |
| `afterEach` | `FamixUTCase` | `forEachInCase` | `FamixUTTearDown` | |
| `beforeAll` | `FamixUTCase` | `forAllInCase` | `FamixUTSetUp` | |
| `beforeEach` | `FamixUTCase` | `forEachInCase` | `FamixUTSetUp` | |
| `testedClass` | `FamixUTCase` | `testCase` | `FamixTType` | |



"
Class {
	#name : 'FamixUTCase',
	#superclass : 'FamixUTEntity',
	#instVars : [
		'#afterAll => FMOne type: #FamixUTTearDown opposite: #forAllInCase',
		'#afterEach => FMOne type: #FamixUTTearDown opposite: #forEachInCase',
		'#beforeAll => FMOne type: #FamixUTSetUp opposite: #forAllInCase',
		'#beforeEach => FMOne type: #FamixUTSetUp opposite: #forEachInCase',
		'#methods => FMMany type: #FamixUTMethod opposite: #case',
		'#suite => FMOne type: #FamixUTSuite opposite: #cases'
	],
	#category : 'Famix-UnitTest-Entities-Entities',
	#package : 'Famix-UnitTest-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FamixUTCase class >> annotation [

	<FMClass: #Case super: #FamixUTEntity>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FamixUTCase >> addMethod: anObject [
	<generated>
	^ self methods add: anObject
]

{ #category : 'accessing' }
FamixUTCase >> afterAll [
	"Relation named: #afterAll type: #FamixUTTearDown opposite: #forAllInCase"

	<generated>
	^ afterAll
]

{ #category : 'accessing' }
FamixUTCase >> afterAll: anObject [

	<generated>
	afterAll := anObject
]

{ #category : 'accessing' }
FamixUTCase >> afterEach [
	"Relation named: #afterEach type: #FamixUTTearDown opposite: #forEachInCase"

	<generated>
	^ afterEach
]

{ #category : 'accessing' }
FamixUTCase >> afterEach: anObject [

	<generated>
	afterEach := anObject
]

{ #category : 'accessing' }
FamixUTCase >> beforeAll [
	"Relation named: #beforeAll type: #FamixUTSetUp opposite: #forAllInCase"

	<generated>
	^ beforeAll
]

{ #category : 'accessing' }
FamixUTCase >> beforeAll: anObject [

	<generated>
	beforeAll := anObject
]

{ #category : 'accessing' }
FamixUTCase >> beforeEach [
	"Relation named: #beforeEach type: #FamixUTSetUp opposite: #forEachInCase"

	<generated>
	^ beforeEach
]

{ #category : 'accessing' }
FamixUTCase >> beforeEach: anObject [

	<generated>
	beforeEach := anObject
]

{ #category : 'accessing' }
FamixUTCase >> methods [
	"Relation named: #methods type: #FamixUTMethod opposite: #case"

	<generated>
	<derived>
	^ methods
]

{ #category : 'accessing' }
FamixUTCase >> methods: anObject [

	<generated>
	methods value: anObject
]

{ #category : 'navigation' }
FamixUTCase >> methodsGroup [
	<generated>
	<navigation: 'Methods'>
	^ MooseSpecializedGroup withAll: self methods asSet
]

{ #category : 'accessing' }
FamixUTCase >> suite [
	"Relation named: #suite type: #FamixUTSuite opposite: #cases"

	<generated>
	<container>
	^ suite
]

{ #category : 'accessing' }
FamixUTCase >> suite: anObject [

	<generated>
	suite := anObject
]

{ #category : 'navigation' }
FamixUTCase >> suiteGroup [
	<generated>
	<navigation: 'Suite'>
	^ MooseSpecializedGroup with: self suite
]

{ #category : 'accessing' }
FamixUTCase >> testedClass [
	"Relation named: #testedClass type: #FamixTType opposite: #testCase"

	<generated>
	<FMProperty: #testedClass type: #FamixTType opposite: #testCase>
	^ self attributeAt: #testedClass ifAbsent: [ nil ]
]

{ #category : 'accessing' }
FamixUTCase >> testedClass: anObject [

	<generated>
	(self attributeAt: #testedClass ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self testedClass.
		self attributeAt: #testedClass put: anObject.
		otherSide testCase: nil ]
	ifNotNil: [ 
		self attributeAt: #testedClass put: anObject.
		anObject testCase: self ]
]
