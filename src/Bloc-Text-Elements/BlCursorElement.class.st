Class {
	#name : #BlCursorElement,
	#superclass : #BlElement,
	#category : 'Bloc-Text-Elements'
}

{ #category : #'hooks - children' }
BlCursorElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.

	self fireEvent: (BlTextCursorAddedToTheSceneEvent new cursorElement: self)
]

{ #category : #'hooks - children' }
BlCursorElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.

	self fireEvent: (BlTextCursorRemovedFromTheSceneEvent new cursorElement: self)
]
