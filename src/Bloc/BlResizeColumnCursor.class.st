Class {
	#name : 'BlResizeColumnCursor',
	#superclass : 'BlNamedCursor',
	#category : 'Bloc-Space - Cursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlResizeColumnCursor >> asForm [
	^ Cursor resizeBottom
]
