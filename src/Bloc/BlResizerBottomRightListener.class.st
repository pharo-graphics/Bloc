Class {
	#name : #BlResizerBottomRightListener,
	#superclass : #BlResizerListener,
	#category : #'Bloc-Utilities - Resizable'
}

{ #category : #resizer }
BlResizerBottomRightListener >> resizeBounds: aBlBounds by: aPoint [
	aBlBounds extent: ((aBlBounds extent + aPoint) max: self minimumExtent)
]

{ #category : #resizer }
BlResizerBottomRightListener >> resizerCursor [
	^ BlCursor resizeBottomRight
]
