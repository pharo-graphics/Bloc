Class {
	#name : #BlTextCursorRemovedFromTheSceneEvent,
	#superclass : #BlEvent,
	#instVars : [
		'cursorElement'
	],
	#category : 'Bloc-Text-Elements'
}

{ #category : #accessing }
BlTextCursorRemovedFromTheSceneEvent >> cursorElement [
	^ cursorElement
]

{ #category : #accessing }
BlTextCursorRemovedFromTheSceneEvent >> cursorElement: anObject [
	cursorElement := anObject
]
