accessing
stroke: aStroke
	stroke := aStroke.
	self updateTextModelStroke.
	self invalidate.