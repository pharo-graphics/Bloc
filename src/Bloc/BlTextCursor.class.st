Class {
	#name : #BlTextCursor,
	#superclass : #BlNamedCursor,
	#category : #'Bloc-Space - Cursor'
}

{ #category : #converting }
BlTextCursor >> asForm [
	^ Cursor overEditableText
]
