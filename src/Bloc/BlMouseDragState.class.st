Class {
	#name : #BlMouseDragState,
	#superclass : #Object,
	#instVars : [
		'button'
	],
	#category : #'Bloc-Space - Support'
}

{ #category : #comparing }
BlMouseDragState >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	^ anotherObject button = self button
]

{ #category : #accessing }
BlMouseDragState >> button [
	^ button
]

{ #category : #accessing }
BlMouseDragState >> button: anObject [
	button := anObject
]

{ #category : #comparing }
BlMouseDragState >> hash [
	^ self class hash bitXor: self button hash
]
