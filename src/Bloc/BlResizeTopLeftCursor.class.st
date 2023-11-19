Class {
	#name : 'BlResizeTopLeftCursor',
	#superclass : 'BlNamedCursor',
	#category : 'Bloc-Space - Cursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlResizeTopLeftCursor >> asForm [
	^ Cursor resizeTopLeft
]
