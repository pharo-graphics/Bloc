cursor - management
removeCursors
	"Remove all visible cursors"

	self cursors do: [ :aCursor | aCursor removeFromParent ].
	cursors removeAll