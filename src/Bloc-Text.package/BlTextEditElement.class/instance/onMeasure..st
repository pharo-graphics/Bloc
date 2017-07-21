layout
onMeasure: anExtentMeasurementSpec
	| aParagraphSpan aTextPosition aCursorElement |
	
	super onMeasure: anExtentMeasurementSpec.
	
	self hasCursor
		ifFalse: [ ^ self ].

	aCursorElement := self cursor.
	aParagraphSpan := self paragraph spanAtIndex: aCursorElement textIndex.
	aTextPosition := aParagraphSpan positionAt: aCursorElement textIndex.

	aCursorElement measuredExtent: (2 @ aParagraphSpan height).
	aCursorElement position: (aTextPosition - (2 @ aParagraphSpan height / 2.0)).
	
	self measuredExtent: (self measuredExtent max: aCursorElement measuredExtent)