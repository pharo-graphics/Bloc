Class {
	#name : 'BlResizeColumnCursor',
	#superclass : 'BlNamedCursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlResizeColumnCursor >> asForm [
	^ Cursor resizeBottom
]
