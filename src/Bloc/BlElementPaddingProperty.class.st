Class {
	#name : #BlElementPaddingProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'padding'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #comparing }
BlElementPaddingProperty >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ padding = anObject padding
]

{ #category : #'api - property' }
BlElementPaddingProperty >> applyOnElement: anElement [
	anElement padding: self padding
]

{ #category : #comparing }
BlElementPaddingProperty >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ padding hash
]

{ #category : #accessing }
BlElementPaddingProperty >> padding [
	^ padding
]

{ #category : #accessing }
BlElementPaddingProperty >> padding: anObject [
	padding := anObject
]
