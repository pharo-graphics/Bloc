Class {
	#name : 'BlResizeLeftCursor',
	#superclass : 'BlNamedCursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlResizeLeftCursor >> asForm [
	^ Cursor resizeLeft
]
