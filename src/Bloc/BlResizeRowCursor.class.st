Class {
	#name : 'BlResizeRowCursor',
	#superclass : 'BlNamedCursor',
	#category : 'Bloc-Space - Cursor',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'converting' }
BlResizeRowCursor >> asForm [
	^ Cursor resizeBottom
]
