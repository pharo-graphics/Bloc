Class {
	#name : #BlResizerTopRightListener,
	#superclass : #BlResizerListener,
	#category : #'Bloc-Utilities - Resizable'
}

{ #category : #resizer }
BlResizerTopRightListener >> resizeBounds: aBlBounds by: aPoint [
	| newExtent |
	
	newExtent := (aBlBounds extent + (aPoint x @ aPoint y negated)) max: self minimumExtent.

	aBlBounds
		origin: aBlBounds position x @ (aBlBounds position y + (aBlBounds extent - newExtent) y)
		extent: newExtent
]

{ #category : #resizer }
BlResizerTopRightListener >> resizerCursor [
	^ BlCursor resizeTopRight
]
