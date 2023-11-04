Class {
	#name : 'BlResizeTopLeftCursor',
	#superclass : 'BlNamedCursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlResizeTopLeftCursor >> asForm [
	^ Cursor resizeTopLeft
]
