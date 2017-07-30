accessing
bounds
	"Return intersection between current selection rectangle and target's bounds.
	Note: for performance reasons we reuse the same bounds object for all events of this type!
	Do not modify or store returned bounds, instead make a #copy!"
	<return: #BlBounds>

	^ bounds