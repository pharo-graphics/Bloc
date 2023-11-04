Class {
	#name : 'BlResizeRowCursor',
	#superclass : 'BlNamedCursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlResizeRowCursor >> asForm [
	^ Cursor resizeBottom
]
