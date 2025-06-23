Class {
	#name : 'FamixUTLoggingPatch',
	#superclass : 'FamixUTAbstractPatch',
	#category : 'Famix-UnitTest-Exporter-Strategies',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Strategies'
}

{ #category : 'hooks' }
FamixUTLoggingPatch >> when: testExporter builtTestCase: aFamixUTCase [

	[ 'Built: ' , aFamixUTCase fullyQualifiedName ] record
]

{ #category : 'hooks' }
FamixUTLoggingPatch >> when: testExporter createdTestCase: aFamixUTCase [

	[ 'Building: ' , aFamixUTCase fullyQualifiedName ] record
]

{ #category : 'hooks' }
FamixUTLoggingPatch >> when: testExporter removedTestCase: aFamixUTCase [

	[
	'Removed ' , aFamixUTCase fullyQualifiedName
	, ' because all method exports failed.' ] record
]

{ #category : 'hooks' }
FamixUTLoggingPatch >> when: testExporter skippedTestMethod: aFamixUTMethod because: exception [

	[
	'Skipped ' , aFamixUTMethod fullyQualifiedName , ' because: '
	, exception asString ] record
]
