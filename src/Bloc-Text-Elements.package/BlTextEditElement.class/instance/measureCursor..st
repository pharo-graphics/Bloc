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
	"make measured cursor size persistent"
	aCursorElement constraints horizontal exact: 1.
	aCursorElement constraints vertical exact: self measuredHeight.

	aCursorElement measuredBounds position: aTextPosition.
	
	self measuredExtent: (self measuredExtent max: self cursor measuredExtent)