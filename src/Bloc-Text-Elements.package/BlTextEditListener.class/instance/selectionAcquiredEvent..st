selection handlers
selectionAcquiredEvent: anEvent
	| aTextEditElement |
	anEvent consumed: true.
		
	aTextEditElement := anEvent currentTarget.
	aTextEditElement border: (BlBorder paint: Color red).
	
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

			self select: aFromIndex to: aToIndex in: aTextEditElement ]