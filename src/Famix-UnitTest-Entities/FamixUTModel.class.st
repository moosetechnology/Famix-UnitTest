Class {
	#name : #FamixUTModel,
	#superclass : #MooseModel,
	#traits : 'FamixUTTEntityCreator + FamixValueTEntityCreator',
	#classTraits : 'FamixUTTEntityCreator classTrait + FamixValueTEntityCreator classTrait',
	#category : #'Famix-UnitTest-Entities-Model'
}

{ #category : #accessing }
FamixUTModel class >> allSubmetamodelsPackagesNames [
	<generated>
	^ #(#'Moose-Query' #'Famix-Value-Entities' #'Famix-Traits')
]

{ #category : #meta }
FamixUTModel class >> annotation [
	<FMClass: #FamixUTModel super: #MooseModel>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
]
