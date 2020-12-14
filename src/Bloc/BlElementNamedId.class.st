Class {
	#name : #BlElementNamedId,
	#superclass : #BlElementId,
	#instVars : [
		'identifier'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #comparing }
BlElementNamedId >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	
	(anObject isKindOf: BlElementId)
		ifFalse: [ ^ false ].
		
	self class = anObject class
		ifTrue: [ ^ identifier = anObject identifier ].

	^ self asSymbol = anObject asSymbol
]

{ #category : #converting }
BlElementNamedId >> asSymbol [
	^ self identifier
]

{ #category : #comparing }
BlElementNamedId >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ identifier hash
]

{ #category : #accessing }
BlElementNamedId >> identifier [
	<return: #Symbol>

	^ identifier
]

{ #category : #accessing }
BlElementNamedId >> identifier: aSymbol [
	identifier
		ifNotNil: [ (BlImmutableObjectChangeError object: self) signal ].

	self
		assert: [ aSymbol notNil ]
		description: [ 'Identifier must not be nil' ].
	
	identifier := aSymbol
]
