Class {
	#name : #BlResizeRowCursor,
	#superclass : #BlNamedCursor,
	#category : #'Bloc-Space - Cursor'
}

{ #category : #converting }
BlResizeRowCursor >> asForm [
	^ Cursor resizeBottom
]
