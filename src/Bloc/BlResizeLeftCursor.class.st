Class {
	#name : 'BlResizeLeftCursor',
	#superclass : 'BlNamedCursor',
	#category : 'Bloc-Space - Cursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlResizeLeftCursor >> asForm [
	^ Cursor resizeLeft
]
