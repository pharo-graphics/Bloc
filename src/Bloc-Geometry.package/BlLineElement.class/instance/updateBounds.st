anchor - geometry
updateBounds
	"Update my bounds by changing my size and relocating me according to curren anchors"
	| anOrigin aCorner aBounds |

	anOrigin := self originPosition.
	aCorner := self cornerPosition.
	aBounds := Rectangle encompassing: { anOrigin. aCorner }.

	self
		relocate: aBounds origin;
		size: (self parentPointToLocal: aBounds extent) + aBounds origin