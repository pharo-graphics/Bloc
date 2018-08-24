Class {
	#name : #BlResizerBottomLeftListener,
	#superclass : #BlResizerListener,
	#category : 'Bloc-Utilities - Resizable'
}

{ #category : #resizer }
BlResizerBottomLeftListener >> resizeBounds: aBlBounds by: aPoint [
	| newExtent |
	
	newExtent := (aBlBounds extent + (aPoint x negated @ aPoint y)) max: self minimumExtent.

	aBlBounds
		origin: (aBlBounds position x + (aBlBounds extent - newExtent) x) @ aBlBounds position y
		extent: newExtent
]

{ #category : #resizer }
BlResizerBottomLeftListener >> resizerCursor [
	^ BlCursor resizeBottomLeft
]
