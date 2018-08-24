Class {
	#name : #BlResizerLeftListener,
	#superclass : #BlResizerListener,
	#category : 'Bloc-Utilities - Resizable'
}

{ #category : #resizer }
BlResizerLeftListener >> resizeBounds: aBlBounds by: aPoint [
	| newExtent |
	
	newExtent := (aBlBounds extent + (aPoint negated x @ 0)) max: self minimumExtent.

	aBlBounds
		origin: aBlBounds position + (aBlBounds extent - newExtent)
		extent: newExtent
]

{ #category : #resizer }
BlResizerLeftListener >> resizerCursor [
	^ BlCursor resizeLeft
]
