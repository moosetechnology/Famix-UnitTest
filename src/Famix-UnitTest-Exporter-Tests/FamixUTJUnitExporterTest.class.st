"
A FamixUTJUnitExporterTest is a test class for testing the behavior of FamixUTJUnitExporter
"
Class {
	#name : #FamixUTJUnitExporterTest,
	#superclass : #TestCase,
	#category : #'Famix-UnitTest-Exporter-Tests'
}

{ #category : #tests }
FamixUTJUnitExporterTest >> assertExport: aFASTEntity equals: expected [

	self
		assert: (FASTJavaExportVisitor new export: aFASTEntity)
		equals: expected
]

{ #category : #tests }
FamixUTJUnitExporterTest >> testExportAct [

	| act method |
	act := FamixUTAct new.
	method := FamixUTMethod new
		          act: act;
		          testedMethod: (FamixJavaMethod new
				           name: 'foo';
				           declaredType: (FamixJavaPrimitiveType new name: 'void');
				           parentType: (FamixJavaClass new name: 'MyClass')).

	"no arg and no return"
	self
		assertExport: (FamixUTJUnitExporter new exportAct: act)
		equals: 'new MyClass().foo();
'.

	"with argument"
	act arguments: { (FamixValueOfPrimitiveType new
			 type: (FamixJavaPrimitiveType new name: 'int');
			 value: 1) }.
	self
		assertExport: (FamixUTJUnitExporter new exportAct: act)
		equals: 'new MyClass().foo(int0);
'.

	"with return"
	method testedMethod declaredType:
		(FamixJavaPrimitiveType new name: 'int').
	self
		assertExport: (FamixUTJUnitExporter new exportAct: act)
		equals: 'int actual = new MyClass().foo(int0);
'
]

{ #category : #tests }
FamixUTJUnitExporterTest >> testExportAssertion [

	| assertion |
	assertion := FamixUTAssertion new expected:
		             (FamixValueOfPrimitiveType new type:
			              (FamixJavaPrimitiveType named: 'int')).
	self
		assertExport: (FamixUTJUnitExporter new exportAssertion: assertion)
		equals: 'assertEquals(int0, actual);
'.

	assertion := FamixUTAssertion new expected:
		             (FamixValueOfPrimitiveType new type:
			              (FamixJavaClass named: 'Integer')).
	self
		assertExport: (FamixUTJUnitExporter new exportAssertion: assertion)
		equals: 'assertEquals((Integer) integer0, actual);
'
]

{ #category : #tests }
FamixUTJUnitExporterTest >> testExportCase [

	| case |
	case := FamixUTCase new testedClass:
		        (FamixJavaClass new name: 'MyClass').

	"empty case"
	self
		assertExport: (FamixUTJUnitExporter new exportCase: case)
		equals: 'public class MyClassTest {
}
'.

	"with method"
	case addMethod:
		(FamixUTMethod new testedMethod: (FamixJavaMethod new
				  name: 'foo';
				  declaredType: (FamixJavaPrimitiveType new name: 'int');
				  parentType: case testedClass)).
	self
		assertExport: (FamixUTJUnitExporter new exportCase: case)
		equals: 'public class MyClassTest {
  @Test
  public void testFoo() {
  }
}
'
]

{ #category : #tests }
FamixUTJUnitExporterTest >> testExportMethod [

	| method testMethod expected assertion setUp type |
	type := FamixJavaPrimitiveType new name: 'int'.
	method := FamixJavaMethod new
		          name: 'foo';
		          declaredType: type;
		          parentType: (FamixJavaClass new name: 'MyClass').
	testMethod := FamixUTMethod new testedMethod: method.
	expected := FamixValueOfPrimitiveType new typedEntity: method.
	assertion := FamixUTAssertion new expected: expected.
	setUp := FamixUTSetUp new.

	"empty"
	self
		assertExport: (FamixUTJUnitExporter new exportMethod: testMethod)
		equals: '@Test
public void testFoo() {
}
'.

	"with act"
	testMethod act:
		(FamixUTAct new arguments: { (FamixValueOfPrimitiveType new
				  type: (FamixJavaPrimitiveType new name: 'int');
				  value: 1) }).
	self
		assertExport: (FamixUTJUnitExporter new exportMethod: testMethod)
		equals: '@Test
public void testFoo() {
  int int0 = 1;
  int actual = new MyClass().foo(int0);
}
'.

	"with assertion"
	testMethod addAssertion: assertion.
	self
		assertExport: (FamixUTJUnitExporter new exportMethod: testMethod)
		equals: '@Test
public void testFoo() {
  int int0 = 1;
  int actual = new MyClass().foo(int0);
  assertEquals(foo1, actual);
}
'
]
