Class {
	#name : #FamixUnitTestGenerator,
	#superclass : #FamixMetamodelGenerator,
	#instVars : [
		'case',
		'suite',
		'fixture',
		'assertion',
		'method',
		'double',
		'setUp',
		'tearDown'
	],
	#category : #'Famix-UnitTest-Generator-Famix-UnitTest-Generator'
}

{ #category : #accessing }
FamixUnitTestGenerator class >> packageName [

	<ignoreForCoverage>
	^ #'Famix-UnitTest-Entities'
]

{ #category : #accessing }
FamixUnitTestGenerator class >> prefix [

	<ignoreForCoverage>
	^ #FamixUT
]

{ #category : #accessing }
FamixUnitTestGenerator class >> submetamodels [

	^ { FamixGenerator }
]

{ #category : #definition }
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
	assertion := builder
		             newClassNamed: #Assertion
		             comment:
		             'Verifies that the behavior or feature being tested behaves as expected.'.
	fixture := builder
		           newClassNamed: #Fixture
		           comment:
		           'Sets up or tears down the system to make tests repeatable.'.
	setUp := builder
		         newClassNamed: #SetUp
		         comment: 'Sets up the system to make tests repeatable.'.
	tearDown := builder
		            newClassNamed: #TearDown
		            comment:
		            'Tears down the system to make tests repeatable.'.
	double := builder
		          newClassNamed: #Double
		          comment:
		          'Object used in testing to replace a real object with a simplified version.'
]

{ #category : #definition }
FamixUnitTestGenerator >> defineHierarchy [

	setUp --|> fixture.
	tearDown --|> fixture
]

{ #category : #definition }
FamixUnitTestGenerator >> defineProperties [

	method property: #name type: #String.
	(assertion property: #errorMargin type: #Object) comment:
		'How much deviation is allowed between the expected and actual values.'
]

{ #category : #definition }
FamixUnitTestGenerator >> defineRelations [

	(suite property: #cases) <>-* case.
	(case property: #methods) <>-* method.
	(method property: #assertions) <>-* assertion.

	(suite property: #setUp) - (setUp property: #suite).
	(suite property: #tearDown) - (tearDown property: #suite).
	(case property: #setUp) - (setUp property: #case).
	(case property: #tearDown) - (tearDown property: #case).
	(method property: #setUp) - (setUp property: #method).
	(method property: #tearDown) - (tearDown property: #method).

	(fixture property: #doubles) *-* (double property: #fixtures).
	(assertion property: #expected)
	*- (double property: #expectedInAssertions).

	(case property: #testedClass)
	-
	((self remoteTrait: #TClass withPrefix: #Famix) property: #unitTest).
	(method property: #testedMethod)
	-
	((self remoteTrait: #TMethod withPrefix: #Famix) property: #unitTest)
]
