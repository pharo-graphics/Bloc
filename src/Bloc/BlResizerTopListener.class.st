Class {
	#name : #BlResizerTopListener,
	#superclass : #BlResizerListener,
	#category : #'Bloc-Utilities - Resizable'
}

{ #category : #resizer }
BlResizerTopListener >> resizeBounds: aBlBounds by: aPoint [
	| newExtent |
	
	newExtent := (aBlBounds extent + (0 @ aPoint negated y)) max: self minimumExtent.

	aBlBounds
		origin: aBlBounds position + (aBlBounds extent - newExtent)
		extent: newExtent
]

{ #category : #resizer }
BlResizerTopListener >> resizerCursor [
	^ BlCursor resizeTop
]
