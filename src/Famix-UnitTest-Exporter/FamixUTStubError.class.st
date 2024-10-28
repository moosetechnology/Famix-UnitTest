Class {
	#name : 'FamixUTStubError',
	#superclass : 'Error',
	#category : 'Famix-UnitTest-Exporter-Exceptions',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Exceptions'
}

{ #category : 'exceptioninstantiator' }
FamixUTStubError class >> signal: aFamixType [

	^ super signal:
		  'Missing sources for the type: ' , aFamixType mooseName
]
