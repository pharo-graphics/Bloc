cursor - management
showCursorAt: anIndex
	"Show a cursor at a given text index"

	self showCursor.
	cursorPosition := anIndex.
	self requestLayout.
	self assertCursor