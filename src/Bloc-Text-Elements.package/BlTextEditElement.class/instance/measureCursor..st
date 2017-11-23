layout
measureCursor: anExtentMeasurementSpec
	| aCursorElement aTextPosition |
	
	self hasCursor
		ifFalse: [ ^ self ].
		
	self assertCursor.

	aCursorElement := self cursor.
	
	"cursor is not within paragraph"
	self paragraph measuredEnd < aCursorElement cursorPosition
		ifTrue: [ ^ self ].

	aTextPosition := self paragraph positionAt: aCursorElement cursorPosition.
	aTextPosition := aTextPosition x @ 0.

	aCursorElement measuredExtent: (1 @ self measuredHeight).
	aCursorElement measuredBounds position: aTextPosition.
	
	self measuredExtent: (self measuredExtent max: self cursor measuredExtent)