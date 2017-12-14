cursor - management
cursorElement: anElement
	| shouldShowCursor |
	"Change a cursor element to a given one"
	
	shouldShowCursor := self hasCursor.

	"remove existing cursor"
	self hideCursor.
	cursorElement := anElement.
	
	"and show a new one if was already visible"
	shouldShowCursor ifTrue: [ self showCursorAt: self cursorPosition ]