Class {
	#name : #BlResizeLeftCursor,
	#superclass : #BlNamedCursor,
	#category : 'Bloc-Space - Cursor'
}

{ #category : #converting }
BlResizeLeftCursor >> asForm [
	^ Cursor resizeLeft
]
