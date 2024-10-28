Class {
	#name : 'FamixUTSkipWarning',
	#superclass : 'Warning',
	#category : 'Famix-UnitTest-Exporter-Exceptions',
	#package : 'Famix-UnitTest-Exporter',
	#tag : 'Exceptions'
}

{ #category : 'signalling' }
FamixUTSkipWarning class >> signalFor: aFamixUTMethod because: anException [

	^ self signal: (String streamContents: [ :s |
			   s << 'Skipping export of ' << aFamixUTMethod name
			   << ' because: '.
			   anException printOn: s ])
]
