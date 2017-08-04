selection handlers
selectionAcquiredEvent: anEvent
	| aTextEditElement |
	super selectionAcquiredEvent: anEvent.
		
	aTextEditElement := anEvent target.
	
	(anEvent bounds = aTextEditElement boundsInLocal)
		ifTrue: [
			self
				select: 0
				to: aTextEditElement text size
				in: aTextEditElement ]
		ifFalse: [ 
			| aFromIndex aToIndex |
			aFromIndex := aTextEditElement paragraph indexAtPosition: anEvent bounds origin.
			aToIndex := aTextEditElement paragraph indexAtPosition: anEvent bounds corner.
	
			self select: aFromIndex to: aToIndex in: aTextEditElement ].
	
	anEvent consumed: true