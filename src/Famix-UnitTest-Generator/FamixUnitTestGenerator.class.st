Class {
	#name : #FamixUnitTestGenerator,
	#superclass : #FamixMetamodelGenerator,
	#instVars : [
		'case',
		'suite',
		'fixture',
		'assertion',
		'method',
		'double'
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
	double := builder
		          newClassNamed: #Double
		          comment:
		          'Object used in testing to replace a real object with a simplified version.'
]

{ #category : #definition }
FamixUnitTestGenerator >> defineProperties [

	(assertion property: #expected type: #Object) comment: ''.
	(assertion property: #actual type: #Object) comment: ''.
	(assertion property: #errorMargin type: #Object) comment: ''
]

{ #category : #definition }
FamixUnitTestGenerator >> defineRelations [

	(suite property: #cases) <>-* case.
	(case property: #methods) <>-* method.
	(method property: #assertions) <>-* assertion.

	(suite property: #setUp) - (fixture property: #setUpInSuite).
	(suite property: #tearDown) - (fixture property: #tearDownInSuite).
	(case property: #setUp) - (fixture property: #setUpInCase).
	(case property: #tearDown) - (fixture property: #tearDownInCase).
	(method property: #setUp) - (fixture property: #setUpInMethod).
	(method property: #tearDown) - (fixture property: #tearDownInMethod).

	(case property: #testedClass)
	-
	((self remoteTrait: #TClass withPrefix: #Famix) property: #unitTest).
	(method property: #testedMethod)
	-
	((self remoteTrait: #TMethod withPrefix: #Famix) property: #unitTest)
]
