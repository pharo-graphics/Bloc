private - layout
updateBounds
	"Update my bounds by changing my size and relocating me according to curren anchors"
	| anOrigin aCorner aBounds |
	
	"ContextStackSignal emit."
	
	self requestLayout.

	