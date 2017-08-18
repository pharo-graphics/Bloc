layout
measureCursor: anExtentMeasurementSpec
	| aCursorElement aParagraphSpan aTextPosition |
	
	self hasCursor
		ifFalse: [ ^ self ].
		
	self assertCursor.

	aCursorElement := self cursor.
	
	"cursor is not within paragraph"
	self paragraph measuredEnd < aCursorElement cursorPosition
		ifTrue: [ ^ self ].
	
	aParagraphSpan := self paragraph spanAtIndex: aCursorElement cursorPosition.
	aTextPosition := aParagraphSpan positionAt: aCursorElement cursorPosition.

	aCursorElement measuredExtent: (1 @ self measuredHeight).
	aCursorElement position: (aTextPosition - (0 @ aParagraphSpan height / 2.0)).
	
	self measuredExtent: (self measuredExtent max: self cursor measuredExtent)