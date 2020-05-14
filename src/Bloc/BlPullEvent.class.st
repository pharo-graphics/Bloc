Class {
	#name : #BlPullEvent,
	#superclass : #BlEvent,
	#instVars : [
		'oldPosition',
		'newPosition',
		'delta'
	],
	#category : #'Bloc-Utilities - Drag&Drop'
}

{ #category : #accessing }
BlPullEvent >> delta [
	^ delta
]

{ #category : #accessing }
BlPullEvent >> delta: anObject [
	delta := anObject
]

{ #category : #accessing }
BlPullEvent >> newPosition [
	^ newPosition
]

{ #category : #accessing }
BlPullEvent >> newPosition: anObject [
	newPosition := anObject
]

{ #category : #accessing }
BlPullEvent >> oldPosition [
	^ oldPosition
]

{ #category : #accessing }
BlPullEvent >> oldPosition: anObject [
	oldPosition := anObject
]
