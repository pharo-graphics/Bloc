selection handlers
selectionAcquiredEvent: anEvent
	| aTextEditElement aFromIndex aToIndex |
	super selectionAcquiredEvent: anEvent.
	
	aTextEditElement := anEvent target.
	
	aFromIndex := aTextEditElement paragraph indexAtPosition: anEvent bounds origin.
	aToIndex := aTextEditElement paragraph indexAtPosition: anEvent bounds corner.
	
	self select: aFromIndex to: aToIndex in: aTextEditElement.
	
	anEvent consumed: true