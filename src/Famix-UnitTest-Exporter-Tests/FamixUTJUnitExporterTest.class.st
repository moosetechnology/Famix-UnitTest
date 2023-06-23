"
A FamixUTJUnitExporterTest is a test class for testing the behavior of FamixUTJUnitExporter
"
Class {
	#name : #FamixUTJUnitExporterTest,
	#superclass : #TestCase,
	#category : #'Famix-UnitTest-Exporter-Tests'
}

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
		assert: (FASTJavaExportVisitor new export:
				 (FamixUTJUnitExporter new exportAct: act))
		equals: 'new MyClass().foo();
'.

	"with argument"
	act arguments: { (FamixValueOfPrimitiveType new
			 type: (FamixJavaPrimitiveType new name: 'int');
			 value: 1) }.
	self
		assert: (FASTJavaExportVisitor new export:
				 (FamixUTJUnitExporter new exportAct: act))
		equals: 'new MyClass().foo(int0);
'.

	"with return"
	method testedMethod declaredType:
		(FamixJavaPrimitiveType new name: 'int').
	self
		assert: (FASTJavaExportVisitor new export:
				 (FamixUTJUnitExporter new exportAct: act))
		equals: 'int actual = new MyClass().foo(int0);
'
]

{ #category : #tests }
FamixUTJUnitExporterTest >> testExportAssertion [

	self
		assert: (FASTJavaExportVisitor new export:
				 (FamixUTJUnitExporter new exportAssertion: FamixUTAssertion new))
		equals: 'assertEquals(expected, actual);
'
]

{ #category : #tests }
FamixUTJUnitExporterTest >> testExportCase [

	| case |
	case := FamixUTCase new testedClass:
		        (FamixJavaClass new name: 'MyClass').

	"empty case"
	self
		assert: (FASTJavaExportVisitor new export:
				 (FamixUTJUnitExporter new exportCase: case))
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
		assert: (FASTJavaExportVisitor new export:
				 (FamixUTJUnitExporter new exportCase: case))
		equals: 'public MyClassTest {
  @Test
  public void testFoo() {
  }
}
'
]

{ #category : #tests }
FamixUTJUnitExporterTest >> testExportMethod [

	| method expected assertion setUp |
	method := FamixUTMethod new testedMethod: (FamixJavaMethod new
			           name: 'foo';
			           declaredType: (FamixJavaPrimitiveType new name: 'int');
			           parentType: (FamixJavaClass new name: 'MyClass')).
	expected := FamixValueOfType new.
	assertion := FamixUTAssertion new expected: expected.
	setUp := FamixUTSetUp new.

	"empty"
	self
		assert: (FASTJavaExportVisitor new export:
				 (FamixUTJUnitExporter new exportMethod: method))
		equals: '@Test
public void testFoo() {
}
'.

	"with act"
	method act:
		(FamixUTAct new arguments: { (FamixValueOfPrimitiveType new
				  type: (FamixJavaPrimitiveType new name: 'int');
				  value: 1) }).
	self
		assert: (FASTJavaExportVisitor new export:
				 (FamixUTJUnitExporter new exportMethod: method))
		equals: '@Test
public void testFoo() {
  int int0 = 1;
  int actual = new MyClass().foo(int0);
}
'.

	"with assertion"
	method addAssertion: assertion.
	self
		assert: (FASTJavaExportVisitor new export:
				 (FamixUTJUnitExporter new exportMethod: method))
		equals: '@Test
public void testFoo() {
  int int0 = 1;
  int actual = new MyClass().foo(int0);
  assertEquals(expected, actual);
}
'
]
