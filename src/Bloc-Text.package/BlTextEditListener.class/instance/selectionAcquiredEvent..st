selection handlers
selectionAcquiredEvent: anEvent
	| aTextEditElement aFromIndex aToIndex |
	super selectionAcquiredEvent: anEvent.
	
	aTextEditElement := anEvent target.
	
	aFromIndex := aTextEditElement paragraph charAtPoint: anEvent bounds origin.
	aToIndex := aTextEditElement paragraph charAtPoint: anEvent bounds corner.
	
	aTextEditElement select: aFromIndex to: aToIndex.
	
	anEvent consumed: true