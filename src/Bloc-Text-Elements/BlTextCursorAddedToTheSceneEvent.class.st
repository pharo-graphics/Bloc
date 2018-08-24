Class {
	#name : #BlTextCursorAddedToTheSceneEvent,
	#superclass : #BlEvent,
	#instVars : [
		'cursorElement'
	],
	#category : 'Bloc-Text-Elements'
}

{ #category : #accessing }
BlTextCursorAddedToTheSceneEvent >> cursorElement [
	^ cursorElement
]

{ #category : #accessing }
BlTextCursorAddedToTheSceneEvent >> cursorElement: anObject [
	cursorElement := anObject
]
