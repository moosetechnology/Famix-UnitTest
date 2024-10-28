Class {
	#name : 'FamixUnitTestGenerator',
	#superclass : 'FamixMetamodelGenerator',
	#instVars : [
		'case',
		'suite',
		'fixture',
		'assertion',
		'method',
		'setUp',
		'tearDown',
		'value',
		'act',
		'actArgument'
	],
	#category : 'Famix-UnitTest-Generator',
	#package : 'Famix-UnitTest-Generator'
}

{ #category : 'accessing' }
FamixUnitTestGenerator class >> packageName [

	<ignoreForCoverage>
	^ #'Famix-UnitTest-Entities'
]

{ #category : 'accessing' }
FamixUnitTestGenerator class >> prefix [

	<ignoreForCoverage>
	^ #FamixUT
]

{ #category : 'accessing' }
FamixUnitTestGenerator class >> submetamodels [

	^ { FamixGenerator. FamixValueGenerator }
]

{ #category : 'definition' }
FamixUnitTestGenerator >> defineClasses [

	suite := builder
		         newClassNamed: #Suite
		         comment: 'A collection of test cases.'.
	case := builder
		        newClassNamed: #Case
		        comment: 'A class containing test methods.'.
	method := builder
		          newClassNamed: #Method
		          comment:
		          'Tests a specific behavior or feature of the system under test.'.
	act := builder
		       newClassNamed: #Act
		       comment: 'Execution of the system under test.'.
	actArgument := builder
		               newClassNamed: #ActArgument
		               comment:
		               'An association between an `Act` and a `Value` argument.'.
	assertion := builder
		             newClassNamed: #Assertion
		             comment:
		             'Verifies that the behavior or feature being tested behaves as expected.'.
	fixture := (builder
		            newClassNamed: #Fixture
		            comment:
		            'Sets up or tears down the system to make tests repeatable.')
		           isAbstractClass: true.
	setUp := builder
		         newClassNamed: #SetUp
		         comment: 'Sets up the system to make tests repeatable.'.
	tearDown := builder
		            newClassNamed: #TearDown
		            comment:
		            'Tears down the system to make tests repeatable.'.
	value := self remoteEntity: #OfType withPrefix: #FamixValue
]

{ #category : 'definition' }
FamixUnitTestGenerator >> defineHierarchy [

	setUp --|> fixture.
	tearDown --|> fixture.

	suite --|> #TNamedEntity.
	"case names aren't configurable by choice"
	method --|> #TNamedEntity
]

{ #category : 'definition' }
FamixUnitTestGenerator >> defineProperties [

	(assertion property: #errorMargin type: #Object) comment:
		'How much deviation is allowed between the expected and actual values.'
]

{ #category : 'definition' }
FamixUnitTestGenerator >> defineRelations [

	(suite property: #cases) <>-* case.
	(case property: #methods) <>-* method.
	(method property: #assertions) <>-* assertion.
	method <>- act.

	(suite property: #setUp) - (setUp property: #suite).
	(suite property: #tearDown) - (tearDown property: #suite).
	(case property: #beforeAll) - (setUp property: #forAllInCase).
	(case property: #afterAll) - (tearDown property: #forAllInCase).
	(case property: #beforeEach) - (setUp property: #forEachInCase).
	(case property: #afterEach) - (tearDown property: #forEachInCase).
	(method property: #setUp) - (setUp property: #method).
	(method property: #tearDown) - (tearDown property: #method).

	(fixture property: #values) *-* (value property: #fixtures).
	(assertion property: #expected)
	*- (value property: #expectedInAssertions).
	(act property: #arguments) -* (actArgument property: #act).
	(actArgument property: #value) *- (value property: #argumentInActs).
	(act property: #receiver) - (value property: #receiverInAct).

	(case property: #testedClass)
	- ((self remoteTrait: #TType withPrefix: #Famix) property: #testCase).
	(method property: #testedMethod)
	*-
	((self remoteTrait: #TMethod withPrefix: #Famix) property: #unitTests)
]
