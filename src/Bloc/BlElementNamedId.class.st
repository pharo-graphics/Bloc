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
	
	"if anObject is of the same class it is faster to directly compare identifiers"
	self class = anObject class
		ifTrue: [ ^ identifier = anObject identifier ].
	
	"otherwise fallback to the symbol comparison, but watch out, #asSymbol may not be cheap!"
	^ self asSymbol = anObject asSymbol
]

{ #category : #converting }
BlElementNamedId >> asSymbol [
	^ self identifier
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
