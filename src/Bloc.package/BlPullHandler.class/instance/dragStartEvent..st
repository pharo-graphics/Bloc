dnd handlers
dragStartEvent: anEvent
	anEvent consumed: true.

	"drag start position in parent"
	dragStartPosition := anEvent currentTarget globalPointToParent: anEvent position.

	"element position in parent"
	originalPosition := anEvent currentTarget position.
