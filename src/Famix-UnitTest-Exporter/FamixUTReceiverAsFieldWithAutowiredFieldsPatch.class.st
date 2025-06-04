"
Useful when the receiver should be managed through dependency injection by a framework, but this mechanism is not directly available in the testing context.
The receiver itself may have injected fields that are handled correctly.

This patch creates an instance variable for the receiver, and assigns to it a new instance of the receiver's class using any constructor.
Before running the test methods, the injected fields are set in the receiver.

```text
class ServiceTest {
	private Service service;

	@Autowired
	private OtherService otherService;

	@Before
	public void autowire() {
		service.setOtherService(otherService);
	}
}
```
"
Class {
	#name : 'FamixUTReceiverAsFieldWithAutowiredFieldsPatch',
	#superclass : 'FamixUTAbstractPatch',
	#category : 'Famix-UnitTest-Exporter-Strategies',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Strategies'
}

{ #category : 'hooks' }
FamixUTReceiverAsFieldWithAutowiredFieldsPatch >> whenTestCaseBuilt: aFamixUTCase on: testExporter [
	"Add 'autowire' method to add properties to the receiver."

	testExporter currentClassHasAutowiredField ifTrue: [
		testExporter makeTestCaseAutowire: aFamixUTCase ]
]

{ #category : 'hooks' }
FamixUTReceiverAsFieldWithAutowiredFieldsPatch >> whenTestCaseCreated: aFamixUTCase on: testExporter [

	testExporter currentClass addDeclaration:
		(testExporter makeNewObjectVarDecl: aFamixUTCase testedClass)
]
