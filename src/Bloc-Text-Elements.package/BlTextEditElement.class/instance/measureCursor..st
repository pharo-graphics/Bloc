layout
measureCursor: anExtentMeasurementSpec
	| aCursorElement aCursorPosition aTextPosition |
	
	self hasCursor
		ifFalse: [ ^ self ].
		
	self assertCursor.

	aCursorElement := self cursorElement.
	aCursorPosition := self cursorPosition.

	"cursor is not within paragraph"
	self paragraph measuredEnd < aCursorPosition
		ifTrue: [ ^ self ].

	aTextPosition := self paragraph positionAt: aCursorPosition.
	aTextPosition := (aTextPosition x - (aCursorElement measuredWidth // 2)) @ 0.
	aCursorElement measuredBounds position: aTextPosition.

	self measuredExtent: (self measuredExtent max: self cursorElement measuredExtent)