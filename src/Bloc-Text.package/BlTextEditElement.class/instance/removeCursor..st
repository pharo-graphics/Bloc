cursor - management
removeCursor: aCursor
	"Remove all visible cursors"

	aCursor removeFromParent.
	self cursors remove: aCursor