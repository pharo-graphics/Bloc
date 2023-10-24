Class {
	#name : #BlResizeTopLeftCursor,
	#superclass : #BlNamedCursor,
	#category : 'Bloc-Space - Cursor'
}

{ #category : #converting }
BlResizeTopLeftCursor >> asForm [
	^ Cursor resizeTopLeft
]
