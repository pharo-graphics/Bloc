Class {
	#name : 'BlTextCursor',
	#superclass : 'BlNamedCursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlTextCursor >> asForm [
	^ Cursor overEditableText
]
