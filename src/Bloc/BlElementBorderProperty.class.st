Class {
	#name : #BlElementBorderProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'border'
	],
	#category : #'Bloc-Basic-Properties'
}

{ #category : #comparing }
BlElementBorderProperty >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ border = anObject border
]

{ #category : #'api - property' }
BlElementBorderProperty >> applyOnElement: anElement [
	anElement border: self border
]

{ #category : #accessing }
BlElementBorderProperty >> border [
	^ border
]

{ #category : #accessing }
BlElementBorderProperty >> border: anObject [
	border := anObject
]

{ #category : #'api - property' }
BlElementBorderProperty >> cleanUpOnElement: anElement [
	anElement border: BlElementVisuals defaultBorder
]

{ #category : #comparing }
BlElementBorderProperty >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ border hash
]

{ #category : #printing }
BlElementBorderProperty >> printOn: aStream [
	aStream
		nextPutAll: 'Border - ';
		print: self border
]
