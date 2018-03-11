dnd handlers
dragStartEvent: anEvent
	anEvent consumed: true.

	"drag start position in parent"
	dragStartPosition := anEvent position.

	"element's original extent"
	originalExtent := self resizeTarget bounds inSpace extent.
	originalPosition := self resizeTarget bounds inSpace position