layout
onMeasure: anExtentMeasurementSpec
	super onMeasure: anExtentMeasurementSpec.
	
	self cursors
		select: [ :aCursorElement | aCursorElement hasParent ]
		thenDo: [ :aCursorElement |
			| aParagraphSpan aTextPosition |
			aParagraphSpan := self paragraph spanAtIndex: aCursorElement textIndex.
			aTextPosition := aParagraphSpan positionAt: aCursorElement textIndex.
			aCursorElement measuredExtent: (2 @ aParagraphSpan height).
			aCursorElement position: (aTextPosition - (2 @ aParagraphSpan height / 2.0)) ]