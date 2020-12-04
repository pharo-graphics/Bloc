Class {
	#name : #BlElementBackgroundProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'background'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #comparing }
BlElementBackgroundProperty >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ background = anObject background
]

{ #category : #'api - property' }
BlElementBackgroundProperty >> applyOnElement: anElement [
	anElement background: self background
]

{ #category : #accessing }
BlElementBackgroundProperty >> background [
	^ background
]

{ #category : #accessing }
BlElementBackgroundProperty >> background: anObject [
	background := anObject
]

{ #category : #'api - property' }
BlElementBackgroundProperty >> cleanUpOnElement: anElement [
	anElement background: BlElementVisuals defaultBackground
]

{ #category : #comparing }
BlElementBackgroundProperty >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ background hash
]
