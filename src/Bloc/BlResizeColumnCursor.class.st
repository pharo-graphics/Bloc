Class {
	#name : #BlResizeColumnCursor,
	#superclass : #BlNamedCursor,
	#category : 'Bloc-Space - Cursor'
}

{ #category : 'converting' }
BlResizeColumnCursor >> asForm [
	^ Cursor resizeBottom
]
