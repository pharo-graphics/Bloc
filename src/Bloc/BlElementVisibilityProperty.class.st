Class {
	#name : #BlElementVisibilityProperty,
	#superclass : #BlElementProperty,
	#instVars : [
		'visibility'
	],
	#category : 'Bloc-Basic-Properties'
}

{ #category : #comparing }
BlElementVisibilityProperty >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ visibility = anObject visibility
]

{ #category : #'api - property' }
BlElementVisibilityProperty >> applyOnElement: anElement [
	anElement visibility: self visibility
]

{ #category : #comparing }
BlElementVisibilityProperty >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ visibility hash
]

{ #category : #accessing }
BlElementVisibilityProperty >> visibility [
	^ visibility
]

{ #category : #accessing }
BlElementVisibilityProperty >> visibility: anObject [
	visibility := anObject
]
