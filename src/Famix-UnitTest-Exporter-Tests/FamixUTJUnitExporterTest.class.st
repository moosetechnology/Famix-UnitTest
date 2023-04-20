"
A FamixUTJUnitExporterTest is a test class for testing the behavior of FamixUTJUnitExporter
"
Class {
	#name : #FamixUTJUnitExporterTest,
	#superclass : #TestCase,
	#category : #'Famix-UnitTest-Exporter-Tests'
}

{ #category : #tests }
FamixUTJUnitExporterTest >> testExportAssertion [

	self
		assert: (FASTJavaExportVisitor new export:
				 (FamixUTJUnitExporter new exportAssertion: FamixUTAssertion new))
		equals: 'assertEquals(expected, actual);
'
]

{ #category : #tests }
FamixUTJUnitExporterTest >> testExportMethod [

	| method act expected assertion setUp |
	method := FamixUTMethod new testedMethod: (FamixJavaMethod new
			           name: 'foo';
			           declaredType: (FamixJavaPrimitiveType new name: 'void');
			           parentType: (FamixJavaClass new name: 'MyClass')).
	act := FamixUTAct new.
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
	method act: act.
	self
		assert: (FASTJavaExportVisitor new export:
				 (FamixUTJUnitExporter new exportMethod: method))
		equals: '@Test
public void testFoo() {
  new MyClass().foo();
}
'.

	"with argument"
	act arguments: { (FamixValueOfPrimitiveType new
			 type: (FamixJavaPrimitiveType new name: 'int');
			 value: 1) }.
	self
		assert: (FASTJavaExportVisitor new export:
				 (FamixUTJUnitExporter new exportMethod: method))
		equals: '@Test
public void testFoo() {
  int int0 = 1;
  new MyClass().foo(int0);
}
'.

	"with return"
	method testedMethod declaredType:
		(FamixJavaPrimitiveType new name: 'int').
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
