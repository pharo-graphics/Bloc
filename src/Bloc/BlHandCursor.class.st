Class {
	#name : 'BlHandCursor',
	#superclass : 'BlNamedCursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlHandCursor >> asForm [
	^ Cursor webLink
]
