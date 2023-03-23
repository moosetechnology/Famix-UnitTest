Class {
	#name : #FamixUTEntity,
	#superclass : #MooseEntity,
	#category : #'Famix-UnitTest-Entities-Entities'
}

{ #category : #meta }
FamixUTEntity class >> annotation [

	<FMClass: #Entity super: #MooseEntity>
	<package: #'Famix-UnitTest-Entities'>
	<generated>
	<abstract>
	^ self
]

{ #category : #testing }
FamixUTEntity class >> isAbstract [

	<generated>
	^ self == FamixUTEntity
]

{ #category : #meta }
FamixUTEntity class >> metamodel [

	<generated>
	^ FamixUTModel metamodel
]
