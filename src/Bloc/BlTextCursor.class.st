Class {
	#name : 'BlTextCursor',
	#superclass : 'BlNamedCursor',
	#category : 'Bloc-Space - Cursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlTextCursor >> asForm [
	^ Cursor overEditableText
]
